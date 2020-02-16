import csv, codecs
from collections import OrderedDict 
from django.utils import timezone
from datetime import datetime
from zm.page.insurer.data_mapper.query import QueryData
from zm.common.file.exportexcel import exportExcelFromListMultiSheet
from zm.common.utils.date_utils import get_month_year
from ..service.download_service import DownloadService
from ..insurer_json_formatter import insurerJsonFormater
from ..json_format_helper import JsonFormatHelper

TITLE = 'INSURER'
FILE_NAME = 'INSURER_保険者マスタ台帳_%s.csv'
NOT_FOUND_DATA = '該当データがありません'
INSURER_000 = 'INSURER_000'

class DownloadLogic:
    output_file_name = 'INSURER_保険者マスタ台帳'
    report_number = 'ZU-P02-PB100'
    max_rows_in_one_page = 12
    json_formatter = insurerJsonFormater
    def __init__(self, *args, **kwargs):    
        self.insurer_name = 'INSURER_000'
        self.remaining_pdf_rows = self.max_rows_in_one_page

    def data_output(self, user_inputs, is_print = False):
        data_out = {}
        csv_data = {}
        insurer_name = INSURER_000
        data_results = QueryData().get_data_export(user_inputs, insurer_name, is_print)
        if not data_results:
            data_out['query_success'] = False
            data_out['message'] = NOT_FOUND_DATA
            return data_out
        if is_print:
            return data_results

        data_insurer = []
        header_csv = DownloadService().create_header()
        data_insurer.append(header_csv)
        for row in data_results:
            data_row = self.format_data(row)
            data_insurer.append(data_row)
        csv_data[TITLE] = data_insurer   
        time_str = int(datetime.timestamp(datetime.now())) 
        now_str = datetime.now().strftime('%Y%m%d')
        file_name = FILE_NAME %(now_str + '_' + str(time_str))
        csv_download_path = DownloadService().exportCSV(data_insurer, file_name)
        data_out['download_path'] = csv_download_path
        return data_out

    def generate_print_json(self, request, result_query, *args, **kwargs):
        final_results = self.final_results_format(self.output_file_name,report_number=self.report_number)
        if result_query:
            final_results['relevant_infos']['query_success'] = True
        else:
            final_results['relevant_infos']['query_success'] = False            
        blocks_info = self.process_query_results_into_blocks(result_query)
        comment_list = [
            '--------------------------------',
            'json- ZU-P02-PB100',
            '--------------------------------'
        ]
        formatter = self.json_formatter(blocks_info,
                                        report_number=final_results['report_number'],
                                        file_name=final_results['file_name'],
                                        comment_list=comment_list)
        print_json = formatter.format_data()
        final_results['print_data'] = print_json
        final_results['relevant_infos']['query_success'] = True

        return final_results

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

            current_block_id = query_row['insurer_000_rid']    
            if is_first_loop:
                last_block_id = current_block_id
            is_new_block = current_block_id not in blocks_info 

            if is_new_block:
                block = self.create_new_block()
                blocks_info[current_block_id] = block
            current_block = blocks_info[current_block_id]    

            if is_new_block:
                block_count += 1
                self.update_page_header(current_block, query_row, block_count)
            if self.is_first_receipt_of_current_insurer(index, query_row, query_rows):
                self.add_row_info(current_block, query_row)
            self.update_page_data(current_block, query_row)
            if self.is_last_receipt_of_current_insurer(index, query_row, query_rows):
                self.remaining_pdf_rows -= 1
                if self.is_last_insurer_of_current_page(index, query_row, query_rows):
                    self.add_info_for_last_insurer_of_page(current_block)
                    self.remaining_pdf_rows = self.max_rows_in_one_page
            last_block_id = current_block_id
            is_first_loop = False      
    
    def add_info_for_last_insurer_of_page(self, block):
        block['data'][self.pdf_row_id]['is_end_of_page'] = True
        block['data'][self.pdf_row_id]['remaining_rows'] = self.remaining_pdf_rows

    def is_last_insurer_of_current_page(self, index, query_row, query_results):
        return any([self.has_no_remaining_rows(),
                    self.is_last_insurer_of_current_block(index, query_row, query_results)])

    def has_no_remaining_rows(self):
        return self.remaining_pdf_rows == 0

    def is_last_insurer_of_current_block(self, index, current_query_row, query_results):
        try:
            next_query_row = query_results[index + 1]
            return next_query_row['insurer_number'] != current_query_row['insurer_number']
        except IndexError:
            return True

    def update_page_data(self, block, query_row):
        data = block['data']
        self.update_row_info(data[self.pdf_row_id], query_row)

    def update_row_info(self, pdf_row, query_rows):
        self.update_data_info(pdf_row, query_rows)    
        
    def is_last_receipt_of_current_insurer(self, index, current_query_row, query_results):
        try:
            next_query_row = query_results[index + 1]
            return True
        except IndexError:
            return True

    def update_data_info(self, pdf_row, query_row):
        pdf_row['opening_class_tcd'] = query_row['opening_class_tcd']
        pdf_row['apply_start_date'] = query_row['apply_start_date']
        pdf_row['apply_end_date'] = query_row['apply_end_date']
        pdf_row['insurance_category_tcd'] = query_row['insurance_category_tcd']
        pdf_row['insurer_law_number'] = query_row['insurer_law_number']
        pdf_row['insurer_jurisdiction_tcd'] = query_row['insurer_jurisdiction_tcd']
        pdf_row['insurer_number'] = query_row['insurer_number']
        pdf_row['insurer_name'] = query_row['insurer_name']
        pdf_row['department_name'] = query_row['department_name']
        pdf_row['insurer_payment_class_tcd'] = query_row['insurer_payment_class_tcd']
        pdf_row['joining_review_board_class_tcd'] = query_row['joining_review_board_class_tcd']
        pdf_row['receipt_summary_report_1_output_class_flag'] = query_row['receipt_summary_report_1_output_class_flag']
        pdf_row['receipt_summary_report_2_output_class_flag'] = query_row['receipt_summary_report_2_output_class_flag']
        pdf_row['billing_statement_output_class_tcd'] = query_row['billing_statement_output_class_tcd']
        pdf_row['billing_statement_split_class_tcd'] = query_row['billing_statement_split_class_tcd']
        pdf_row['billing_document_attach_class_tcd'] = query_row['billing_document_attach_class_tcd']

    def add_row_info(self, current_block, query_row):
        self.pdf_row_id = query_row['insurer_number']
        current_block['data'][self.pdf_row_id] = self.init_row()

    def init_row(self):
        return {
            'opening_class_tcd': '',
            'apply_start_date': '',
            'apply_end_date': '',
            'insurance_category_tcd': '',
            'insurer_law_number': '',
            'insurer_jurisdiction_tcd': '',
            'insurer_number': '',
            'insurer_name': '',
            'department_name': '',
            'insurer_payment_class_tcd': '',
            'joining_review_board_class_tcd': '',
            'receipt_summary_report_1_output_class_flag': '',
            'receipt_summary_report_2_output_class_flag': '',
            'billing_statement_output_class_tcd': '',
            'billing_statement_split_class_tcd': '',
            'billing_document_attach_class_tcd': '',
        }   
    
    def is_first_receipt_of_current_insurer(self, index, current_query_row, query_results):
        if index == 0:  # First row in entire query_results
            return True

        try:
            last_query_row = query_results[index - 1]
            return last_query_row['insurer_id'] != current_query_row['insurer_id']
        except IndexError:
            return True
    
    def update_page_header(self, block, query_row, block_count):
        header = block['header']
        header.update({
            '作成日付': query_row['作成日付'],
        })            

    def create_new_block(self):
        return {
            'header': {},
            'data': OrderedDict(),
            'footer': {},
        }


    def current_insurer_is_individual_page(self, query_row):
        return False
        # for index, query_row in enumerate(query_rows):
        #     if check_individual_page_insurer and self.current_insurer_is_individual_page(query_row):
        #         individual_page_insurers.append(query_row)
        #         continue

        #     current_block_id = query_row['block_id']

        #     if is_first_loop:
        #         last_block_id = current_block_id

        #     is_new_block = current_block_id not in blocks_info

        #     if is_new_block:
        #         block = self.create_new_block()
        #         blocks_info[current_block_id] = block

        #     current_block = blocks_info[current_block_id]

        #     if is_new_block:
        #         block_count += 1
        #         self.update_page_header(current_block, query_row, block_count)
        #         self.update_page_footer(current_block, query_row)

        #     if self.is_first_receipt_of_current_insurer(index, query_row, query_rows):
        #         self.add_row_info(current_block, query_row)

        #     children_of_current_insurer = self.get_children_of_current_insurer(query_row, child_insurers)
        #     target_query_rows = [query_row] + children_of_current_insurer

        #     for row in target_query_rows:
        #         self.update_page_data(current_block, row)
        #         self.update_page_aggregation(current_block, row)

        #     self.remove_evaluated_insurers(children_of_current_insurer, child_insurers)

        #     if self.is_last_receipt_of_current_insurer(index, query_row, query_rows):
        #         self.remaining_pdf_rows -= 1

        #         if self.is_last_insurer_of_current_page(index, query_row, query_rows):
        #             self.add_next_page_aggregation(current_block)
        #             self.add_info_for_last_insurer_of_page(current_block)
        #             self.reset_remaining_rows()

        #     last_block_id = current_block_id
        #     is_first_loop = False


    def filter_child_insurers(self, query_results):
        child_insurer = []
        child_insurer_indexes = []
        for index, row in enumerate(query_results):
            child_insurer_indexes.append(index)
            child_insurer.append(row)
        return child_insurer, child_insurer_indexes    


    def final_results_format(self, file_name, report_number=''):
        final_results = {
            'file_name': file_name,
            'report_number': report_number,
            'print_data': {},
            'relevant_infos': {
                'action': 'print',
                'query_success': True
            }
        }
        return final_results

    def format_data(self, row_data):
        value_data = []
        value_data.append(row_data['opening_class_tcd'])
        value_data.append(row_data['apply_start_date'])
        value_data.append(row_data['apply_end_date'])
        value_data.append(row_data['insurance_category_tcd'])
        value_data.append(row_data['insurer_law_number'])
        value_data.append(row_data['insurer_jurisdiction_tcd'])
        value_data.append(row_data['insurer_number'])
        value_data.append(row_data['insurer_name'])
        value_data.append(row_data['department_name'])
        value_data.append(row_data['insurer_payment_class_tcd'])
        value_data.append(row_data['joining_review_board_class_tcd'])
        value_data.append(row_data['receipt_summary_report_1_output_class_flag'])
        value_data.append(row_data['receipt_summary_report_2_output_class_flag'])
        value_data.append(row_data['billing_statement_output_class_tcd'])
        value_data.append(row_data['billing_statement_split_class_tcd'])
        value_data.append(row_data['billing_document_attach_class_tcd'])
        
        return value_data


