#!/usr/bin/python
# -*- coding: utf-8 -*-
'''
全柔協次世代システムプロジェクト

2019/08/06 DuongTrung@Gisoft 新規作成
'''

__author__   = 'ExS'
__status__   = 'develop'
__version__  = '0.0.0_0'
__date__	 = '2019/08/06'

# ------------------------------------------------------------
## Import Section
# ------------------------------------------------------------
# python
from collections import OrderedDict

# zen
from .U01PB001_config_reader import U01PB001ConfigReader
from .U01PB001_json_formatter import U01PB001JsonFormater

from zm.common import const as zm_const
from zm.page.print import const as print_const
from zm.common.model import getClass

from zm.page.print.helper.print_helper import PrintHelper
from zm.page.print.logic.print_logic import PrintLogic
from zm.page.print.services.print_services import PrintServices

# ------------------------------------------------------------
## Variable Section
# ------------------------------------------------------------

TWO_BYTE_SPACE = '　'

SPECIAL_TREATMENT = '特別療養'

MODE_FIRST_ISSUE = 'first_issue'
MODE_RE_ISSUE = 're_issue'

RELEVANT_TABLES = (
    'ORGANIZATION_000', 'ORGANIZATION_001', 'FACILITY_000', 'FACILITY_001',
    'FACILITY_010', 'PRACTITIONER_000', 'INSURER_000', 'INSURER_001',
)

# ------------------------------------------------------------
## Function Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## Class Section
# ------------------------------------------------------------


class U01PB001(PrintHelper, PrintLogic, PrintServices):
    config_reader = U01PB001ConfigReader('U01PB001/config_U01PB001.json')
    json_formatter = U01PB001JsonFormater
    output_file_name = 'U01PB001_柔道整復施術療養費支給申請総括票（Ⅰ）'
    report_number = 'ZU-P02-PB001'
    relevant_tables = (
        'ORGANIZATION_000', 'ORGANIZATION_001', 'FACILITY_000', 'FACILITY_001',
        'FACILITY_010', 'PRACTITIONER_000', 'INSURER_000', 'INSURER_001',
    )
    max_rows_in_one_page = 12

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.receipt_name = 'RECEIPT_100'
        self.department = self.get_department_from_receipt_names(self.receipt_name)
        self.remaining_pdf_rows = self.max_rows_in_one_page

    def generate_print_json(self, request, *args, **kwargs):
        final_results = self.final_result_format(print_const.PRINT_ACTION,
                                                 self.output_file_name,
                                                 report_number=self.report_number)

        self.user_inputs = self.get_user_inputs(request)
        self.current_config_row = self.config_reader.get_config_row(verbose_name=self.user_inputs['pattern'])

        sql, parameters = self.construct_sql_and_parameters()
        query_results = self.query_to_db(sql, parameters)

        if not query_results:
            final_results['relevant_infos']['query_success'] = False
            return final_results
        else:
            final_results['relevant_infos']['query_success'] = True


        # If user choose mode 'first issue', then use the billing_date (from user input) to update
        # to billing_date of all receipts in query_results
        if self.user_inputs['mode'] == MODE_FIRST_ISSUE:
            self.update_billing_date(query_results, self.user_inputs['billing_date'], request)

        blocks_info = self.process_query_results_into_blocks(query_results)

        comment_list = [
            '--------------------------------',
            'json- ZU-P02-PB001',
            '--------------------------------'
        ]
        formatter = self.json_formatter(blocks_info,
                                        config=self.current_config_row,
                                        report_number=final_results['report_number'],
                                        file_name=final_results['file_name'],
                                        comment_list=comment_list)
        print_json = formatter.format_data()

        final_results['print_data'] = print_json
        final_results['relevant_infos']['query_success'] = True

        return final_results

    def get_user_inputs(self, request):
        form_data = request.POST
        first_day_of_month = '-01'

        if form_data['mode'] == MODE_FIRST_ISSUE:
            billing_date = form_data['billing_date_first_issue']
        elif form_data['mode'] == MODE_RE_ISSUE:
            billing_date = form_data['billing_date_re_issue']
        else:
            billing_date = None

        user_inputs = {
            'mode': form_data.get('mode', ''),
            'billing_date': self.convert_date_format(billing_date) + first_day_of_month,
            'closing_target_date_from': self.split_from_to(form_data.get('closing_target_date', ''))[0],
            'closing_target_date_to': self.split_from_to(form_data.get('closing_target_date', ''))[1],
            'pattern': form_data.get('pattern', ''),  # (Verbose name)
            'insurer_jurisdiction_tcd_from': self.split_from_to(form_data.get('insurer_jurisdiction_tcd', ''))[0],
            'insurer_jurisdiction_tcd_to': self.split_from_to(form_data.get('insurer_jurisdiction_tcd', ''))[1],
            'practitioner_number_from': self.split_from_to(form_data.get('practitioner_number', ''))[0],
            'practitioner_number_to': self.split_from_to(form_data.get('practitioner_number', ''))[1],
            'facility_number_from': self.split_from_to(form_data.get('facility_number', ''))[0],
            'facility_number_to': self.split_from_to(form_data.get('facility_number', ''))[1],
            'session_company': request.session[zm_const.SESSION_COMPANY],
        }
        return user_inputs

    def construct_sql_and_parameters(self):
        sql_params = {}

        sql_select = self.construct_select()
        sql_from_and_join = self.construct_from_and_join()
        sql_where = self.construct_where(sql_params)
        sql_order = self.construct_order_by()

        full_sql = sql_select + sql_from_and_join + sql_where + sql_order
        return full_sql, sql_params

    def construct_select(self):
        sql_select = """
            SELECT
                CONCAT(INSURER_000.insurer_jurisdiction_tcd,
                       FACILITY_000.address_pref_tcd,
                       PRACTITIONER_000.practitioner_number) AS block_id,
                INSURER_000.did AS insurer_id,
                {receipt_name}.insurance_category_number,
                {receipt_name}.rid,
                {receipt_name}.billing_date,
                FACILITY_001.registered_symbol_number,
                CONCAT(PRACTITIONER_000.last_name, '{two_byte_space}',
                       PRACTITIONER_000.first_name) AS practitioner_full_name,
                FACILITY_000.facility_name,
                CONCAT(FACILITY_000.address_pref_tcd,
                       FACILITY_000.facility_number,
                       PRACTITIONER_000.practitioner_number) AS membership_number,
                INSURER_000.insurer_jurisdiction_tcd,
                INSURER_000.insurer_name,
                INSURER_000.insurer_number,
                {receipt_name}.{head_family_class_tcd} AS head_family_class_tcd,
                {receipt_name}.total_amount,
                ORGANIZATION_001.for_insurers_name,
                FACILITY_010.operating_organization_code,
                INSURER_000.general_insurer_d_id
        """\
            .format(receipt_name=self.receipt_name,
                    two_byte_space=TWO_BYTE_SPACE,
                    head_family_class_tcd=self.get_column_name_by_department('head_family_class_tcd'))
        return sql_select

    def construct_from_and_join(self):
        sql_from_and_join = """
            FROM {receipt_name}
        """
        sql_from_and_join += self.inner_join_organization_000(self.receipt_name)
        sql_from_and_join += self.inner_join_organization_001()
        sql_from_and_join += self.inner_join_practitioner_000(self.receipt_name)
        sql_from_and_join += self.inner_join_facility_001('PRACTITIONER_000')
        sql_from_and_join += self.inner_join_facility_000(['FACILITY_001', self.receipt_name])
        sql_from_and_join += self.inner_join_insurer_000(self.receipt_name)
        sql_from_and_join += self.inner_join_insurer_001()
        sql_from_and_join += self.left_join_facility_010()

        sql_from_and_join = sql_from_and_join.format(receipt_name=self.receipt_name)

        return sql_from_and_join

    def construct_where(self, sql_params):
        # NOTE: Because all other tables are already joined to ORGANIZATION_000.did
        # so only ORGANIZATION_000.did = %(session_company)s is
        # enough for all default conditions about session company
        sql_where = """
            WHERE
                ORGANIZATION_000.did = %(session_company)s
        """
        sql_params.update({
            'session_company': self.user_inputs['session_company']
        })

        # Conditions base on mode choose by user
        if self.user_inputs['mode'] == MODE_FIRST_ISSUE:
            sql_where += """
                AND {receipt_name}.billing_date IS NULL
            """
            sql_where += self.handle_from_to_input(self.receipt_name, 'closing_target_date',
                                                   self.user_inputs['closing_target_date_from'],
                                                   self.user_inputs['closing_target_date_to'], sql_params)
        elif self.user_inputs['mode'] == MODE_RE_ISSUE:
            sql_where += """
                AND {receipt_name}.billing_date = %(billing_date_re_issue)s
            """
            sql_params.update({
                'billing_date_re_issue': self.user_inputs['billing_date'],
            })

        # Default conditions

        sql_where += ' AND '
        default_sql_where = []
        default_sql_where.append(self.default_conditions_receipts_are_not_deleted(self.receipt_name))
        default_sql_where.append(self.default_conditions_receipts_are_checked(self.receipt_name))
        default_sql_where.append(self.default_conditions_receipts_association(self.receipt_name))
        default_sql_where.append(self.default_conditions_for_facility_000(self.department))
        default_sql_where.append(self.default_conditions_for_facility_001(self.department))
        default_sql_where.append(self.default_conditions_for_organization_001(self.department))
        default_sql_where.append(self.default_conditions_for_insurer_001(self.department))
        sql_where += ' AND '.join(default_sql_where)
        sql_where += """
            AND INSURER_001.receipt_summary_report_1_output_class_flag = 1
        """

        # Other default conditions base on insurance type choose by user (refer to config json)
        sql_where += self.get_extra_sql_by_pattern(sql_params)

        # Conditions base on user's search
        sql_where += self.handle_from_to_input('INSURER_000', 'insurer_jurisdiction_tcd',
                                                self.user_inputs['insurer_jurisdiction_tcd_from'],
                                                self.user_inputs['insurer_jurisdiction_tcd_to'], sql_params)
        sql_where += self.handle_from_to_input('PRACTITIONER_000', 'practitioner_number',
                                                self.user_inputs['practitioner_number_from'],
                                                self.user_inputs['practitioner_number_to'], sql_params)
        sql_where += self.handle_from_to_input('FACILITY_000', 'facility_number',
                                                self.user_inputs['facility_number_from'],
                                                self.user_inputs['facility_number_to'], sql_params)

        # Filter revision
        period_start = self.get_last_day_of_month(self.user_inputs['billing_date'])
        sql_where += self.get_extra_sql_by_max_revision(self.relevant_tables, period_start, sql_params)

        sql_where = sql_where.format(receipt_name=self.receipt_name)

        return sql_where

    def construct_order_by(self):
        # We order by ISNULL(INSURER_000.general_insurer_d_id) first so that all child insurers
        # are ordered top, this helps the process of aggregating child insurers info to their
        # general insurer's info more efficient
        sql_order = """
            ORDER BY
                ISNULL(INSURER_000.general_insurer_d_id),
                block_id,
                INSURER_000.insurance_category_tcd,
                INSURER_000.insurer_number,
                insurer_id
        """\
            .format(receipt_name=self.receipt_name,
                    insurance_class_tcd=self.get_column_name_by_department('insurance_class_tcd'))
        return sql_order

    def get_column_name_by_department(self, base_column_name):
        j_receipts = ('RECEIPT_100',)
        aq_receipts = ('RECEIPT_200',)
        m_receipts = ('RECEIPT_300',)
        if self.receipt_name in j_receipts:
            return 'j_%s' % base_column_name
        if self.receipt_name in aq_receipts:
            return 'aq_%s' % base_column_name
        if self.receipt_name in m_receipts:
            return 'm_%s' % base_column_name

    def get_extra_sql_by_pattern(self, sql_params):
        """Generate extra sql base on json config file
        """
        extra_sql = ''
        extra_sql += self.get_insurance_category_number_conditions(sql_params)
        extra_sql += self.get_insurer_jurisdiction_tcd_conditions(sql_params)

        extra_sql = extra_sql.format(receipt_name=self.receipt_name)
        return extra_sql

    def get_insurance_category_number_conditions(self, sql_params):
        allowed_categories_str = self.config_reader.get_config_value(self.current_config_row, 'insurance_category_number')
        allowed_categories_list = self.config_reader.parse_numbers(allowed_categories_str)

        applied_relation_cat_numbers_str = self.config_reader.get_config_value(self.current_config_row,
                                                                               'relation_insurance_category_number')
        applied_relation_cat_numbers_list = self.config_reader.parse_numbers(applied_relation_cat_numbers_str)

        extra_sql = ''
        extra_sql += self.generate_dynamic_sql(self.receipt_name, 'insurance_category_number', 'IN',
                                               allowed_categories_list, sql_params)
        extra_sql += self.generate_dynamic_sql(self.receipt_name, 'relation_insurance_category_number', 'IN',
                                               applied_relation_cat_numbers_list, sql_params)

        return extra_sql

    def get_insurer_jurisdiction_tcd_conditions(self, sql_params):
        allowed_prefs_str = self.config_reader.get_config_value(self.current_config_row, 'insurer_jurisdiction_tcd')
        allowed_prefs_list = self.config_reader.parse_numbers(allowed_prefs_str)
        extra_sql = self.generate_dynamic_sql('INSURER_000', 'insurer_jurisdiction_tcd', 'IN',
                                              allowed_prefs_list, sql_params)
        return extra_sql

    def process_query_results_into_blocks(self, query_results):
        child_insurers, child_insurers_indexes = self.filter_child_insurers(query_results)
        for insurer in child_insurers:
            insurer['is_child_insurer'] = True

        parent_insurers = [row for index, row in enumerate(query_results) if index in child_insurers_indexes]

        individual_page_insurers = []
        blocks_info = OrderedDict()
        self.update_blocks_info(blocks_info, parent_insurers, child_insurers,
                                check_individual_page_insurer=True,
                                individual_page_insurers=individual_page_insurers)

        self.update_blocks_info(blocks_info, individual_page_insurers, child_insurers,
                                check_individual_page_insurer=False)

        return blocks_info

    def update_blocks_info(self, blocks_info, query_rows, child_insurers,
                           check_individual_page_insurer=False,
                           individual_page_insurers=None):
        is_first_loop = True
        last_block_id = None
        block_count = 0

        for index, query_row in enumerate(query_rows):
            if check_individual_page_insurer and self.current_insurer_is_individual_page(query_row):
                individual_page_insurers.append(query_row)
                continue

            current_block_id = query_row['block_id'] #block id của phần tử kq tìm kiếm

            if is_first_loop: #kt đây có phải block đầu hay ko
                last_block_id = current_block_id #nếu đúng gán block sau và block trước = nhau

            is_new_block = current_block_id not in blocks_info  # kiểm tra block hiện tại ko nằm trong block_info

            if is_new_block: #nếu không
                block = self.create_new_block() #tạo block mới
                blocks_info[current_block_id] = block #tạo đối tượng mới trong block_info với key là block id và value là block mới dc tạo

            current_block = blocks_info[current_block_id] #gán curent block cho value của block_info[curent_block_id]

            if is_new_block:
                block_count += 1 #đếm số block
                self.update_page_header(current_block, query_row, block_count) #thêm vào header những trường nào sẽ hiển thị ở bên trên
                self.update_page_footer(current_block, query_row) #thêm vào footer những trường nào sẽ hiển thị ở bên dưới

            if self.is_first_receipt_of_current_insurer(index, query_row, query_rows): #kiểm tra có phải phần tử đầu tiên hay không
                self.add_row_info(current_block, query_row) #thêm các trường vào data (phần body)

            children_of_current_insurer = self.get_children_of_current_insurer(query_row, child_insurers)
            target_query_rows = [query_row] + children_of_current_insurer

            for row in target_query_rows:
                self.update_page_data(current_block, row) #Cập nhật data
                self.update_page_aggregation(current_block, row)

            self.remove_evaluated_insurers(children_of_current_insurer, child_insurers)

            if self.is_last_receipt_of_current_insurer(index, query_row, query_rows):
                self.remaining_pdf_rows -= 1

                if self.is_last_insurer_of_current_page(index, query_row, query_rows):#kiểm tra bản ghi cuối hay không
                    self.add_next_page_aggregation(current_block)
                    self.add_info_for_last_insurer_of_page(current_block) #nếu là bản ghi cuối thì thêm 2 trường is_end_of_page và remaining_row vào phần data
                    self.reset_remaining_rows() #reset remaining pdf row

            last_block_id = current_block_id
            is_first_loop = False

    def current_insurer_is_individual_page(self, query_row):
        return False  # Only PB116 feature has individual page case, PB001 doesn't have it

    def is_first_receipt_of_current_insurer(self, index, current_query_row, query_results):
        if index == 0:  # First row in entire query_results
            return True

        try:
            last_query_row = query_results[index - 1]
            return last_query_row['insurer_id'] != current_query_row['insurer_id']
        except IndexError:
            return True

    def add_row_info(self, current_block, query_row):
        # Because we aggregate child insurer info with general insurer info
        # row_id must be general_insurer_d_id if its not Null
        self.pdf_row_id = query_row['insurer_id']
        current_block['data'][self.pdf_row_id] = self.init_row()

    def is_last_receipt_of_current_insurer(self, index, current_query_row, query_results):
        try:
            next_query_row = query_results[index + 1]
            return next_query_row['insurer_id'] != current_query_row['insurer_id']
        except IndexError:
            return True

    def is_last_insurer_of_current_page(self, index, query_row, query_results):
        return any([self.has_no_remaining_rows(),
                    self.is_last_insurer_of_current_block(index, query_row, query_results)])

    def has_no_remaining_rows(self):
        return self.remaining_pdf_rows == 0

    def is_last_insurer_of_current_block(self, index, current_query_row, query_results):
        try:
            next_query_row = query_results[index + 1]
            return next_query_row['block_id'] != current_query_row['block_id']
        except IndexError:
            return True

    def add_next_page_aggregation(self, block):
        block['aggregation'].append(self.init_page_aggregation())

    def add_info_for_last_insurer_of_page(self, block):
        block['data'][self.pdf_row_id]['is_end_of_page'] = True
        block['data'][self.pdf_row_id]['remaining_rows'] = self.remaining_pdf_rows

    def filter_child_insurers(self, query_results):
        # Because we order by isnull(general_insurer_d_id) at sql, now all child insurers
        # will be on top of query_results.
        # We also return indexes of child insurers, so that we can skip those indexes in
        # the next step
        child_insurers = []
        child_insurers_indexes = []
        for index, row in enumerate(query_results):
            if row['general_insurer_d_id'] is None:
                break
            child_insurers.append(row)
            child_insurers_indexes.append(index)
        return child_insurers, child_insurers_indexes

    def get_children_of_current_insurer(self, row, child_insurers):
        current_insurer_did = row['insurer_id']
        children_of_current_insurer = []

        for child_insurer in child_insurers:
            if child_insurer['general_insurer_d_id'] == current_insurer_did:
                children_of_current_insurer.append(child_insurer)

        return children_of_current_insurer

    def remove_evaluated_insurers(self, evaluated_insurers, child_insurers):
        for insurer in evaluated_insurers:
            del child_insurers[child_insurers.index(insurer)]

    def create_new_block(self):
        return {
            'header': {},
            'data': OrderedDict(),
            'footer': {},
            'aggregation': [
                self.init_page_aggregation(),
            ],
        }

    @staticmethod
    def init_row():
        return {
            'insurer_name': '',
            'insurer_number': '',
            'receipt_count_person': 0,
            'total_amount_person': 0,
            'receipt_count_family': 0,
            'total_amount_family': 0,
            'receipt_count_total': 0,
            'total_amount_total': 0,
        }

    @staticmethod
    def init_page_aggregation():
        return {
            'person_aggregate_receipt_count': 0,
            'person_aggregate_total_amount': 0,
            'family_aggregate_receipt_count': 0,
            'family_aggregate_total_amount': 0,
            'sum_aggregate_receipt_count': 0,
            'sum_aggregate_total_amount': 0,
        }

    def update_page_header(self, block, query_row, block_count):
        header = block['header']
        header.update({
            'billing_date': '',
            'registered_symbol_number': query_row['registered_symbol_number'],
            'practitioner_full_name': query_row['practitioner_full_name'],
            'facility_name': query_row['facility_name'],
            'membership_number': query_row['membership_number'],
            'insurer_jurisdiction_tcd': query_row['insurer_jurisdiction_tcd'],
            'block_count': block_count,
            'special_treatment': '',
            'facility_code': '',
        })
        header.update(self.update_header_billing_date(query_row))
        header.update(self.update_header_special_treatment(query_row))
        header.update(self.update_header_facility_code(query_row))

    def update_header_billing_date(self, query_row):
        if self.user_inputs['mode'] == MODE_FIRST_ISSUE:
            return {'billing_date': self.user_inputs['billing_date']}
        else:
            return {'billing_date': query_row['billing_date']}

    def update_header_special_treatment(self, query_row):
        is_special_treatment = self.check_special_treatment(query_row)
        if is_special_treatment:
            return {'special_treatment': SPECIAL_TREATMENT}
        return {}

    def update_header_facility_code(self, query_row):
        is_print_facility_code = self.check_facility_code(query_row)
        if is_print_facility_code:
            return {'facility_code': query_row['operating_organization_code']}
        return {}

    def update_page_data(self, block, query_row):
        data = block['data']
        self.update_row_info(data[self.pdf_row_id], query_row)

    def update_page_footer(self, block, query_row):
        block['footer'].update({
            'for_insurers_name': query_row['for_insurers_name']
        })

    def check_new_insurer(self, row_id, data):
        return row_id not in data

    def check_child_insurer(self, row):
        return row.get('is_child_insurer', False)

    def update_row_info(self, pdf_row, query_row):
        self.update_insurer_info(pdf_row, query_row)
        self.update_summary_info(pdf_row, query_row)

    def update_insurer_info(self, pdf_row, query_row):
        if not self.check_child_insurer(query_row):
            pdf_row['insurer_name'] = query_row['insurer_name']
            pdf_row['insurer_number'] = query_row['insurer_number']

    def update_summary_info(self, pdf_row, query_row):
        is_person_row = self.is_person_row(query_row)
        is_family_row = self.is_family_row(query_row)

        if is_person_row:
            pdf_row['receipt_count_person'] += 1
            pdf_row['total_amount_person'] += query_row['total_amount'] or 0

        elif is_family_row:
            pdf_row['receipt_count_family'] += 1
            pdf_row['total_amount_family'] += query_row['total_amount'] or 0

        if is_person_row or is_family_row:
            pdf_row['receipt_count_total'] += 1
            pdf_row['total_amount_total'] += query_row['total_amount'] or 0

    def update_page_aggregation(self, block, query_row):
        aggregation = block['aggregation'][-1]
        is_person_row = self.is_person_row(query_row)
        is_family_row = self.is_family_row(query_row)

        if is_person_row:
            aggregation['person_aggregate_receipt_count'] += 1
            aggregation['person_aggregate_total_amount'] += query_row['total_amount'] or 0

        elif is_family_row:
            aggregation['family_aggregate_receipt_count'] += 1
            aggregation['family_aggregate_total_amount'] += query_row['total_amount'] or 0

        if is_person_row or is_family_row:
            aggregation['sum_aggregate_receipt_count'] += 1
            aggregation['sum_aggregate_total_amount'] += query_row['total_amount'] or 0

    def reset_remaining_rows(self):
        self.remaining_pdf_rows = self.max_rows_in_one_page

    @staticmethod
    def is_person_row(row):
        return row['head_family_class_tcd'] == '2'

    @staticmethod
    def is_family_row(row):
        return row['head_family_class_tcd'] == '6'

    def check_facility_code(self, row):
        prefecture_string = self.config_reader.get_config_value(self.current_config_row, 'organization_code')
        prefecture_list = self.config_reader.parse_numbers(prefecture_string)
        if row['insurer_jurisdiction_tcd'] in prefecture_list:
            return True
        else:
            return False

    def check_special_treatment(self, row):
        special_insurance_types_str = self.config_reader.get_config_value(self.current_config_row, 'special_treatment')
        special_insurance_types_list = self.config_reader.parse_numbers(special_insurance_types_str)
        if row['insurance_category_number'] in special_insurance_types_list:
            return True
        else:
            return False

    def update_billing_date(self, query_results, billing_date, request):
        receipt_model = getClass(self.receipt_name)
        rid_list = [result['rid'] for result in query_results]
        receipts = receipt_model.objects.filter(rid__in=rid_list)
        for receipt in receipts:
            setattr(receipt, 'billing_date', billing_date)
            receipt.save(request)
