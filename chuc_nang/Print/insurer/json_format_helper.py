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
# zen
from .print_helper import PrintHelper

# ------------------------------------------------------------
## Variable Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## Function Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## Class Section
# ------------------------------------------------------------


class JsonFormatHelper:
    """Helps map query output to the correct json format
    that can be understand in print section (at batch server)
    """
    _final_results = 'final_results'
    _header_info = 'header_info'
    _rows_info = 'rows_info'
    _extra_info = 'extra_info'

    def __init__(self, print_data, file_name='', report_number='',
                 font='ipamjm', comment_list=None, *args, **kwargs):
        """
        :param print_data: data get from logic function
        :param font: default font is ipamjm (leave this blank if you want to use batch server's default font)
        :param comment_list: list of comments, default is None
        """
        self.print_data = print_data
        self.file_name = file_name
        self.report_number = report_number
        self.font = font
        self.comment_list = comment_list
        self.line = self.construct_line()
        self.utils = PrintHelper()

    def get_config(self, font=None):
        return {
            "font": font if font else self.font
        }

    def get_comment(self, comment_list=None):
        comments = comment_list if comment_list else self.comment_list
        if isinstance(comments, list):
            return comments
        else:
            return []

    def construct_json(self, config, comment, items):
        """Construct the final json structure
        Call this function at the end

        WARNING: This method is being deprecated, don't use it in future features,
                 use construct_single_report and then construct_print_json instead
        """
        report_data = {
            'CONFIG': config,
            'COMMENT': comment,
            'ITEM': items
        }

        json = {
            "REPORT": [
                {
                    "NAME": self.file_name,
                    "ID": "ZEN000001",
                    "REPORT_LIST": [
                        {
                            "REPORT_NUMBER": self.report_number,
                            "REPORT_DATA": report_data,
                        }
                    ]
                }
            ]
        }
        return json

    def construct_single_report(self, report_number=None, report_name=None, config=None,
                                comment=None, items=None):
        report_number = report_number or self.report_number
        report_name = report_name or self.file_name
        config = config or self.get_config()
        comment = comment or self.get_comment()

        single_report = {
            "NAME": report_name,
            "REPORT_NUMBER": report_number,
            "REPORT_DATA": {
                "CONFIG": config,
                "COMMENT": comment,
                "ITEM": items
            },
        }

        return single_report

    def construct_print_json(self, report_list, output_file_name=None, output_id='ZEN000001'):
        output_file_name = output_file_name or self.file_name

        json = {
            "REPORT": [
                {
                    "NAME": output_file_name,
                    "ID": output_id,
                    "REPORT_LIST": report_list
                }
            ]
        }
        return json

    @staticmethod
    def construct_single_section(page, data_type, value):
        section = {
            'PAGE': page,
            'TYPE': data_type,
            'VALUE': value
        }
        return section

    @staticmethod
    def construct_line(page='001', data_type='DATA', value=[['']]):
        """Construct a line section
        With the current code, line section is identical to
        a normal data section, but 'VALUE' is default to [['']]
        """
        section = {
            'PAGE': page,
            'TYPE': data_type,
            'VALUE': value
        }
        return section

    @staticmethod
    def get_items(item_list):
        """
        :param item_list: list of all items each section is another list
        """
        # items = [
        #     item for item in item_list
        # ]
        return item_list

    @staticmethod
    def get_page(page_number):
        """
        :param page_number: int
        """
        return '%03d' % page_number

    @staticmethod
    def get_type(data_type):
        """
        :param data_type: str, can be DATA / HEADER / SECTION_LOOP
        """
        return data_type

    @staticmethod
    def get_value(value_rows):
        """
        :param value_rows: list of lists, with each list coresponse to a data row
        """
        return value_rows
