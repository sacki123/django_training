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
import datetime
import os
import boto3
import jaconv
from calendar import monthrange
from collections import OrderedDict

# django
from django.utils import timezone
from django.conf import settings

# zen
from zm.common.const import SESSION_USER_NAME
from zm.page.print import const as print_const
from zm.common.file.read_files import read_json_file, read_tcd_file
from zm.common.model import getClass

# ------------------------------------------------------------
## Variable Section
# ------------------------------------------------------------

WAREKI_JSON_REL_PATH = r'../data/db/wareki/wareki.json'

# ------------------------------------------------------------
## Function Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## Class Section
# ------------------------------------------------------------


class PrintHelper:
    """Helper class for print view"""

    @staticmethod
    def format_return_json(json):
        """
        Get uniform json return
        """
        json['message'] = ''
        json['error'] = False
        json['data'] = {}
        return json

    @staticmethod
    def get_sys_info(session):
        """Get general system info"""
        sys_info = {
            'EXE_USER': session[SESSION_USER_NAME],
            'EXE_DATE': datetime.datetime.strftime(timezone.now().date(), '%Y-%m-%d'),
            'PROGRAM_NAME': 'TEST',
            'VERSION': __version__
        }
        return sys_info

    @staticmethod
    def convert_date_format(date):
        """Convert 2018/08/08 to 2019-08-08 to use in db query"""
        if not date:
            return None
        return date.replace('/', '-')

    def convert_dict_value_to_str(self, dictionary, zero_to_blank=False):
        """Convert all values of a dict to string
        If zero_to_blank is True: when value is 0 or '0', convert to empty string
        """
        stringified_dict = {}
        for key, val in dictionary.items():
            if val == 0 or val == '0':
                if zero_to_blank is True:
                    new_val = ''
                else:
                    new_val = str(val)
            elif val is None:
                new_val = ''
            elif isinstance(val, int):
                new_val = self.add_thousand_separator(val)
            else:
                new_val = str(val)
            stringified_dict.update({key: new_val})
        return stringified_dict

    def convert_rows_info_to_str(self, rows_info_values):
        """
        In order to send json to batch server to print, everything must be string
        This function does that conversion
        """
        str_rows_info = []
        for section in rows_info_values:
            str_row = self.convert_dict_value_to_str(section, zero_to_blank=True)
            str_rows_info.append(str_row)
        return str_rows_info

    def get_wareki_info(self, date, date_format='%Y-%m-%d'):
        """
        Get wareki info base on wareki.json
        """
        if isinstance(date, str):
            date = datetime.datetime.strptime(date, date_format)
        if isinstance(date, datetime.datetime):
            date = date.date()  # Convert to date

        wareki_json_path = os.path.join(settings.BASE_DIR, WAREKI_JSON_REL_PATH)
        wareki_dict = read_json_file(wareki_json_path)

        for era_name, era_info in wareki_dict.items():
            era_begin_str = self.correct_date_string_format(era_info['begin_date'])
            era_end_str = self.correct_date_string_format(era_info['end_date'])
            era_begin = datetime.datetime.strptime(era_begin_str, '%Y-%m-%d').date()
            era_end = datetime.datetime.strptime(era_end_str, '%Y-%m-%d').date()

            if date >= era_begin and date <= era_end:
                return {
                    'en': era_info['en'],                                   # Example: "heisei"
                    'begin_date': era_info['begin_date'],                   # Example: "1989-01-08"
                    'end_date': era_info['end_date'],                       # Example: "2019-04-30"
                    'kana': era_info['kana'],                               # Example: "へいせい"
                    'nickname': era_info['nickname'],                       # Example: "H"
                    'ja': era_info['ja'],                                   # Example: "平成"
                    'year_ad': str(date.year),                              # Example: "2018"
                    'year_wareki': str(date.year - era_begin.year + 1),     # Example: "30"
                    'month': str(date.month),                               # Month of input date
                    'day': str(date.day),                                   # Day of input date
                }

        # If find no era, return blank
        return {
            'en': '',
            'begin_date': '',
            'end_date': '',
            'kana': '',
            'nickname': '',
            'ja': '',
            'year_ad': '',
            'year_wareki': '',
            'month': '',
            'day': '',
        }

    @staticmethod
    def correct_date_string_format(date_str, divider='-'):
        """
        In wareki mapping file, dates can be in strange format, the number of digits per
        position is not consistent. Example: '900-1-12' (the prefered format is '0900-01-12')
        So we need to correct them first
        """
        year, month, day = date_str.split(divider)
        year = year.zfill(4)
        month = month.zfill(2)
        day = day.zfill(2)
        new_date_str = divider.join([year, month, day])
        return new_date_str

    @staticmethod
    def split_from_to(input_value):
        """
        For range input, mikan return in this format: '{from}:{to}'
        Why? No one knows, just have to go with the flow
        """
        if not input_value:
            return '', ''
        _from, _to = input_value.split('}:{')
        _from = _from[1:]
        _to = _to[:-1]
        return _from, _to

    @staticmethod
    def get_last_day_of_month(date, date_format='%Y-%m-%d'):
        """
        :param date: can be date or datetime object or string, if it's string, you can define its format,
                     the default format is '%Y-%m-%d'
        """
        if isinstance(date, str):
            date = datetime.datetime.strptime(date, date_format)

        last_day = monthrange(date.year, date.month)[1]
        date = date.replace(day=last_day)
        return date

    @staticmethod
    def add_thousand_separator(number, separator=','):
        if number is None:
            return ''
        if isinstance(number, str):
            try:
                if '.' in number:
                    number = float(number)
                else:
                    number = int(number)
            except (TypeError, ValueError):
                return ''
        new_number = '{:,}'.format(number)
        new_number = new_number.replace(',', separator)
        return new_number

    @staticmethod
    def convert_tcd_info(target='name', file_name='common_0002_tcd', **kwargs):  # NOTE: Maybe common this function?
        """Convert info in tcd file
        Example: You have prefecture number, and you want to get prefecture name:
            convert_tcd_info(tcd='27', target='name', file_name='common_0002_tcd')
            -> Go to tcd file 'common_0002_tcd', get 'name' where 'tcd' = 27
        """
        key, val = '', ''
        for k, v in kwargs.items():
            key, val = k, v
        prefs = read_tcd_file(file_name)
        for pref in prefs.values():
            if pref[key] == val:
                return pref[target]
        return ''

    def convert_date_to_wareki(self, date, date_format='%Y-%m-%d', include_day=True):
        """Convert date to wareki string
        """
        if not date:
            return ''
        wareki = self.get_wareki_info(date, date_format=date_format)
        wareki_str = wareki['ja'] + \
                     wareki['year_wareki'].zfill(2) + '-' + \
                     wareki['month'].zfill(2)
        if include_day:
            wareki_str += '-' + wareki['day'].zfill(2)
        return wareki_str

    def get_full_address(self, address_pref_tcd, address_city,
                         address_town, address_street):
        pref = self.convert_tcd_info(tcd=address_pref_tcd, target='name', file_name='common_0002_tcd')
        pref = '' if pref is None else pref
        address_pref_tcd = '' if address_pref_tcd is None else address_pref_tcd
        address_city = '' if address_city is None else address_city
        address_town = '' if address_town is None else address_town
        address_street = '' if address_street is None else address_street
        full_address = pref + address_city + address_town + address_street
        return full_address

    def get_membership_number(self, facility_pref, facility_number, practitioner_number):
        facility_pref = '' if facility_pref is None else str(facility_pref)
        facility_number = '' if facility_number is None else str(facility_number)
        practitioner_number = '' if practitioner_number is None else str(practitioner_number)
        membership_number = facility_pref + facility_number + practitioner_number
        return membership_number

    def get_full_name(self, last_name, first_name, separator='　', to_half_width=False):
        """Concat last name and first name into full name
        Default separator between last and first is a 2-byte space
        """
        last_name = '' if last_name is None else str(last_name)
        first_name = '' if first_name is None else str(first_name)
        separator = separator if last_name and first_name else ''  # separator is not needed if there is only 1 name
        full_name = last_name + separator + first_name
        if to_half_width:
            full_name = jaconv.z2h(full_name)
        return full_name

    def count_treatment_dates(self, treatment_dates, target_day='1'):
        """Count number of target_day in treatment_dates
        """
        if not treatment_dates:
            return 0

        if not isinstance(target_day, list):
            target_day = [target_day]

        count = 0
        for day in target_day:
            count += treatment_dates.count(day)

        return count

    @staticmethod
    def final_result_format(action, file_name, report_number=''):
        """
        This is the return format of main function
        If the query return results, those results are processed and append to 'excel_data' or 'print_data'
                                     and final_results['relevant_infos']['query_success'] = True
        If the query don't return any thing, final_results['relevant_infos']['query_success'] = False
        Other related info (if there is) is added to 'relevant_infos'

        :param action: 'print' or 'excel'
        :param file_name: name of pdf/excel file to be output
        :param report_number: name of mapping module on batch server
                              Ex: 'ZU-P02-PB001' => map to ZU-P02-PB001.py module on batch server
        """
        if action == 'excel':
            final_results = {
                'file_name': file_name,
                'excel_data': [],
                'relevant_infos': {
                    'action': 'excel',
                    'query_success': False
                },
            }
        elif action == 'print':
            final_results = {
            'file_name': file_name,
            'report_number': report_number,
            'print_data': {},
            'relevant_infos': {
                'action': 'print',
                'query_success': False
            },
        }
        return final_results

    def get_department_from_receipt_names(self, receipt_names):
        if not isinstance(receipt_names, list):
            receipt_names = [receipt_names]

        for department, receipt_list in print_const.RECEIPT_DEPARTMENT_MAP.items():
            if set(receipt_names) == set(receipt_list):
                return department

    def sort_results(self, query_results, unique_columns):
        """Sort query results into list of lists
        Each child list include results with something in common

        Example: If you want to group all receipts returned by query into
        sub-group of receipts with same insurer_number and practitioner_number, then:
            unique_columns = ['insurer_number', 'practitioner_number']
            groups = self.sort_results(query_results, unique_columns)

        :param query_results: list of dicts (returned by sql query)
        :param unique: string used for grouping key
        """
        groups = OrderedDict()
        for result in query_results:
            current_key = ''.join(str(result[column]) for column in unique_columns)
            if current_key not in groups:
                groups[current_key] = [result]
            else:
                groups[current_key].append(result)
        # Convert groups into list of lists
        groups = list(groups.values())
        return groups

    def get_family_class_col(self, receipt_name):
        return print_const.FAMILY_TCD_COL_NAME_MAP[receipt_name]['family']

    def get_family_age_class_col(self, receipt_name):
        return print_const.FAMILY_TCD_COL_NAME_MAP[receipt_name]['age']

    def format_dotted_date(self, date, include_day=True, include_era=False):
        """Change date to this format: 29.04.30, 01.09,...
        """
        if not date:
            return ''

        wareki_info = self.get_wareki_info(date)
        era = wareki_info['nickname']
        year = wareki_info['year_wareki'].zfill(2)
        month = wareki_info['month'].zfill(2)
        day = wareki_info['day'].zfill(2)
        formatted_date = '%s.%s' % (year, month)
        if include_day:
            formatted_date = formatted_date + '.' + day
        if include_era:
            formatted_date = era + formatted_date
        return formatted_date

    @staticmethod
    def format_percentage(number, include_percentage_sign=True):
        percentage = str(round(number * 100))
        if include_percentage_sign:
            percentage += '%'
        return percentage
