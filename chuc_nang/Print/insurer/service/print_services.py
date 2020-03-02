#!/usr/bin/python
# -*- coding: utf-8 -*-
'''
全柔協次世代システムプロジェクト

2019/05/29 DuongTrung@Gisoft 新規作成
'''

__author__   = 'ExS'
__status__   = 'develop'
__version__  = '0.0.0_0'
__date__	 = '2019/05/29'

# ------------------------------------------------------------
## Import Section
# ------------------------------------------------------------
# python
from collections import namedtuple

# django
from django.db import connection

# zen
from zm.page.print import const as print_const
from zm.common.model import getClass
from zm.common.services.model_services import get_newest_rids
from zm.common.services.raw_sql_services import RawSqlService

# ------------------------------------------------------------
## Variable Section
# ------------------------------------------------------------
# Models
REPORT = getClass('REPORT')

DEPARTMENT_MAP = print_const.DEPARTMENT_MAP

# ------------------------------------------------------------
## Function Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## Class Section
# ------------------------------------------------------------


class PrintServices:
    """Class relates to database interaction of print view"""

    raw_sql_helper = RawSqlService()

    def get_query_result(self, queries):
        """return query result"""

        results = {}
        for query in queries:
            r_id, query, params = query[0], query[1], query[2]
            query = query.replace(u'\xa0', u' ')  # \xa0 is no-breaking-space, sometimes appear in xml file, making the query fail
            with connection.cursor() as cursor:
                cursor.execute(query, params)
                result = self.__named_tuple_fetchall(cursor)
            results.update({r_id: result})
        return results

    def query_to_db(self, sql, sql_params):
        return self.raw_sql_helper.query_to_db(sql, sql_params)

    def get_pdf_file_path(self, report_id):
        """Get pdf file path on S3 from Report table to start download"""

        record = REPORT.objects.filter(renable=1, report_id=report_id).values('storage_file_path').first()
        return record['storage_file_path']

    def dictfetchall(self, cursor):
        return self.raw_sql_helper.dictfetchall(cursor)

    def __named_tuple_fetchall(self, cursor):
        "Return all rows from a cursor as a namedtuple"

        desc = cursor.description
        nt_result = namedtuple('Result', [col[0] for col in desc])
        result = self.__convert_to_str(cursor)  # Extra step: convert to string
        return [nt_result(*row) for row in result]

    def __convert_to_str(self, cursor):
        """Convert all result from cursor to string"""

        result = cursor.fetchall()
        # Convert result from tuple to list so that it's editable
        result = [list(r) for r in result]
        # Convert everything inside result into string
        result = [[str(r) for r in res] for res in result]
        return result

    def get_status_report(self, report_id):
        record = REPORT.objects.filter(renable=1, report_id=report_id).values('status', 'storage_file_path', 'error_message').first()
        return record

    @staticmethod
    def get_extra_sql_by_filter_revision(model_name, period_start, period_end=None):
        """
        NOTE !Important: This function is going to be deprecated, use get_extra_sql_by_max_revision() instead
        It is still here because many features are already using this function and we haven't got the time
        to review all of them
        """
        if not period_end:
            period_end = period_start
        extra_sql = ''
        extra_params = {}
        newest_rids = get_newest_rids(model_name, period_start, period_end=period_end)
        if newest_rids:
            extra_sql += " AND %s.rid IN " % model_name.upper()
            param_place_holder = 'newest_rids_%s' % model_name.lower()
            extra_sql += "%%(%s)s" % param_place_holder
            extra_params[param_place_holder] = newest_rids
        return extra_sql, extra_params

    def get_extra_sql_by_max_revision(self, table_list, period_start, __=None, period_end=None, check_temporary_flag=True):
        # NOTE: argument __ used to be sql_params, but since rid is fetch from db, not user input, so putting inside
        # sql_params to avoid sql injection is uneccessary, so this argument is redundant. Set __=None is to prevent
        # this change from affecting codes that already used it
        return self.raw_sql_helper.get_extra_sql_by_max_revision(table_list, period_start, __=__,
                                                                 period_end=period_end,
                                                                 check_temporary_flag=check_temporary_flag)

    def generate_dynamic_sql(self, table, column, operator, input_value, parameters,
                             suffix='AND', skip_empty_inputs=True, skip_empty_wildcard_input=True):
        """Refer to raw_sql_services.RawSqlService.generate_dynamic_sql
        # NOTE: The weird prefix=suffix part is simply due to miss-spelling, but since too many features
                are using this function, it's difficult to change
        """
        return self.raw_sql_helper.generate_dynamic_sql(table, column, operator, input_value, parameters,
                                                        prefix=suffix, skip_empty_inputs=skip_empty_inputs,
                                                        skip_empty_wildcard_input=skip_empty_wildcard_input)

    def handle_from_to_input(self, table, column, _from, _to, parameters,
                             default_operator='AND', number_coerce_func=int):
        """Refer to raw_sql_services.RawSqlService.handle_from_to_input
        """
        return self.raw_sql_helper.handle_from_to_input(table, column, _from, _to, parameters,
                                                        default_operator=default_operator,
                                                        number_coerce_func=number_coerce_func)

    def construct_gte_lte_sql(self, table, column, from_value, to_value, parameters):
        return self.raw_sql_helper.construct_gte_lte_sql(table, column,
                                                         from_value, to_value, parameters)

    def construct_equal_sql(self, table, column, value, parameters):
        return self.raw_sql_helper.construct_equal_sql(table, column, value, parameters)

    @staticmethod
    def default_conditions_receipts_are_not_deleted(receipt_name, delete_flag_col='delete_flag'):
        extra_sql = """
            (%(receipt_name)s.%(delete_flag)s = 0)
        """ % {
            'receipt_name': receipt_name,
            'delete_flag': delete_flag_col,
        }
        return extra_sql

    @staticmethod
    def default_conditions_receipts_are_checked(receipt_name, check_date_col='receipt_check_date',
                                                              error_col='receipt_error'):
        """Default conditions that receipts are all checked and all errors (if there are) is fixed
        """
        extra_sql = """
            (%(receipt_name)s.%(receipt_check_date)s IS NOT NULL
            AND (%(receipt_name)s.%(receipt_error)s IS NULL
                 OR %(receipt_name)s.%(receipt_error)s = ''))
        """ % {
            'receipt_name': receipt_name,
            'receipt_check_date': check_date_col,
            'receipt_error': error_col,
        }
        return extra_sql

    @staticmethod
    def default_conditions_receipts_are_billed(receipt_name, billing_date_col='billing_date'):
        """Default conditions that receipts are all billed
        (billing_date is not NULL)
        """
        extra_sql = """
            (%(receipt_name)s.%(billing_date)s IS NOT NULL)
        """ % {
            'receipt_name': receipt_name,
            'billing_date': billing_date_col,
        }
        return extra_sql

    @staticmethod
    def default_conditions_receipts_association(receipt_name, return_col='association_return_flag',
                                                              pending_col='association_pending_class_tcd'):
        extra_sql = """
            (%(receipt_name)s.%(association_return_flag)s = 0
            AND (%(receipt_name)s.%(association_pending_class_tcd)s IS NULL
                 OR %(receipt_name)s.%(association_pending_class_tcd)s = ''))
        """ % {
            'receipt_name': receipt_name,
            'association_return_flag': return_col,
            'association_pending_class_tcd': pending_col,
        }
        return extra_sql

    @staticmethod
    def default_conditions_for_organization_001(department):
        """
        :param department: str -> department can be 'J' or 'AQM'
        NOTE: Default conditions that involve delete_flag, temporary_registration_flag
        are added when filtering revision
        """
        opening_class_tcd = DEPARTMENT_MAP[department]['opening_class_tcd']
        extra_sql = """
            (ORGANIZATION_001.opening_class_tcd = '%s')
        """ % opening_class_tcd
        return extra_sql

    @staticmethod
    def default_conditions_for_facility_000(department):
        """
        :param department: str -> department can be 'J' or 'AQM'
        """
        opening_class_tcd = DEPARTMENT_MAP[department]['opening_class_tcd']
        extra_sql = """
            (FACILITY_000.opening_class_tcd = '%s')
        """ % opening_class_tcd
        return extra_sql

    @staticmethod
    def default_conditions_for_facility_001(department, check_register_practitioner=True):
        """
        :param department: str -> department can be 'J' or 'AQM'
        """
        license_tcd = DEPARTMENT_MAP[department]['practitioner_license_tcd']
        registered_tcd = DEPARTMENT_MAP[department]['registered_practitioner_tcd']
        if not isinstance(license_tcd, list):
            license_tcd = list(license_tcd)

        sql = """
            FACILITY_001.practitioner_license_tcd IN %(license)s
        """ % {
            'license': '(' + ', '.join("'" + tcd + "'" for tcd in license_tcd) + ')'
        }

        if check_register_practitioner:
            sql += """
                AND FACILITY_001.registered_practitioner_tcd = '%(register)s'
            """ % {
                'register': registered_tcd
            }

        sql = '(' + sql + ')'
        return sql

    @staticmethod
    def default_conditions_for_facility_010(department, left_join=True):
        """
        If left_join=True, FACILITY_010 is joined using LEFT JOIN, so all conditions cannot
        apply if current row is not joined to any FACILITY_010 record
        :param department: str -> department can be 'J' or 'AQM'
        """
        medical_department_class_tcd = DEPARTMENT_MAP[department]['medical_department_class_tcd']
        if not isinstance(medical_department_class_tcd, list):
            medical_department_class_tcd = list(medical_department_class_tcd)

        medical_department_class_tcd_str = '(' + ', '.join("'" + tcd + "'" for tcd in medical_department_class_tcd) + ')'

        if left_join:
            sql = """
                FACILITY_010.rid IS NULL
                OR
                FACILITY_010.medical_department_class_tcd IN %(medical_department_class_tcd)s
            """ % {
                'medical_department_class_tcd': medical_department_class_tcd_str
            }
        else:
            sql = """
                FACILITY_010.medical_department_class_tcd IN %(medical_department_class_tcd)s
            """ % {
                'medical_department_class_tcd': medical_department_class_tcd_str
            }

        sql = '(' + sql + ')'
        return sql

    @staticmethod
    def default_conditions_insurer_is_not_general():
        extra_sql = """
            (INSURER_000.general_insurer_flag = 0)
        """
        return extra_sql

    @staticmethod
    def default_conditions_for_insurer_001(department):
        opening_class_tcd = DEPARTMENT_MAP[department]['opening_class_tcd']
        extra_sql = """
            (INSURER_001.opening_class_tcd = '%s')
        """ % opening_class_tcd
        return extra_sql

    @staticmethod
    def inner_join_organization_000(receipt_name, join_col='organization_000_d_id'):
        # NOTE: If other inner_join_... functions takes join_organization=True
        # then this function must be called first before all other functions
        # (Because you must join with ORGANIZATION_000 first, then other tables can also
        # join to ORGANIZATION_000)
        extra_sql = """
            INNER JOIN ORGANIZATION_000
                ON ORGANIZATION_000.did = %(receipt_name)s.%(organization_000_d_id)s
        """ % {
            'receipt_name': receipt_name,
            'organization_000_d_id': join_col,
        }
        return extra_sql

    @staticmethod
    def inner_join_organization_001():
        extra_sql = """
            INNER JOIN ORGANIZATION_001
                ON ORGANIZATION_001.organization_000_d_id = ORGANIZATION_000.did
        """
        return extra_sql

    @staticmethod
    def inner_join_organization_002():
        extra_sql = """
            INNER JOIN ORGANIZATION_002
                ON ORGANIZATION_002.organization_000_d_id = ORGANIZATION_000.did
        """
        return extra_sql

    @staticmethod
    def inner_join_facility_000(join_sources, join_col='facility_000_d_id', join_organization=True):
        # Always consider join_sources as a list
        if not isinstance(join_sources, (list, tuple)):
            join_sources = [join_sources]

        # First part of extra_sql (before ON conditions)
        extra_sql = """
            INNER JOIN FACILITY_000 ON
        """

        # ON conditions part
        on_conditions = []
        for source_table in join_sources:
            condition = """
                FACILITY_000.did = %(source_table)s.%(source_join_column)s
            """ % {
                'source_table': source_table,
                'source_join_column': join_col
            }
            on_conditions.append(condition)

        # Merge first part to ON conditions part
        extra_sql += ' AND '.join(on_conditions)

        if join_organization:
            extra_sql += """
                AND FACILITY_000.organization_000_d_id = ORGANIZATION_000.did
            """
        return extra_sql

    @staticmethod
    def inner_join_facility_001(join_source='FACILITY_000', join_organization=True):
        extra_sql = """
            INNER JOIN FACILITY_001
                ON FACILITY_001.%(join_column)s = %(join_source)s.did
        """ % {
            'join_column': join_source.lower() + '_d_id',
            'join_source': join_source
        }
        if join_organization:
            extra_sql += """
                AND FACILITY_001.organization_000_d_id = ORGANIZATION_000.did
            """
        return extra_sql

    @staticmethod
    def left_join_facility_010(join_organization=True):
        """If you want to inner join FACILITY_010, you must join to INSURER_000 and FACILITY_001 first
        """
        extra_sql = """
            LEFT JOIN FACILITY_010
                ON FACILITY_010.facility_001_d_id = FACILITY_001.did
                AND FACILITY_010.insurer_jurisdiction_tcd = INSURER_000.insurer_jurisdiction_tcd
        """
        if join_organization:
            extra_sql += """
                AND FACILITY_010.organization_000_d_id = ORGANIZATION_000.did
            """
        return extra_sql

    @staticmethod
    def inner_join_practitioner_000(receipt_name, join_col='practitioner_000_d_id', join_organization=True):
        extra_sql = """
            INNER JOIN PRACTITIONER_000
                ON PRACTITIONER_000.did = %(receipt_name)s.%(practitioner_000_d_id)s
        """ % {
            'receipt_name': receipt_name,
            'practitioner_000_d_id': join_col,
        }
        if join_organization:
            extra_sql += """
                AND PRACTITIONER_000.organization_000_d_id = ORGANIZATION_000.did
            """
        return extra_sql

    @staticmethod
    def inner_join_insurer_000(receipt_name, join_col='insurer_000_d_id'):
        extra_sql = """
            INNER JOIN INSURER_000
                ON INSURER_000.did = %(receipt_name)s.%(insurer_000_d_id)s
        """ % {
            'receipt_name': receipt_name,
            'insurer_000_d_id': join_col,
        }
        return extra_sql

    @staticmethod
    def inner_join_insurer_001():
        extra_sql = """
            INNER JOIN INSURER_001
                ON INSURER_001.insurer_000_d_id = INSURER_000.did
        """
        return extra_sql

    @staticmethod
    def get_unique_param_key(column, parameters, suffix=''):
        """Create a key that is not duplicate in parameters
        by keep appending higher index until it's unique

        If a suffix is defined, the key will be added wthat suffix first
        """
        index = 0
        param_key = column + suffix
        while param_key in parameters:
            index += 1
            param_key += str(index)
        return param_key

    @staticmethod
    def split_by_comma(text):
        if not text:
            return []
        return [t.strip() for t in text.split(',')]
