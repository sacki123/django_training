#!/usr/bin/python
# -*- coding: utf-8 -*-
'''
全柔協次世代システムプロジェクト

2019/10/07 DuongTrung@Gisoft 新規作成
'''

__author__   = 'ExS'
__status__   = 'develop'
__version__  = '0.0.0_0'
__date__	 = '2019/10/07'

# ------------------------------------------------------------
## Import Section
# ------------------------------------------------------------
# zen
from zm.common import utils
from zm.page.print.helper.json_format_helper import JsonFormatHelper

# ------------------------------------------------------------
## Variable Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## Function Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## Class Section
# ------------------------------------------------------------


class U01PB001JsonFormater(JsonFormatHelper):

    def __init__(self, *args, config=None, **kwargs):
        super().__init__(*args, **kwargs)
        self.config = config
        self.font = 'meiryo'

    def format_data(self):
        items_list = []
        for block in self.print_data.values():
            header = self.construct_header(block)#format
            data = self.construct_data(block)
            footer = self.construct_footer(block)
            item = [header, data, footer]
            items_list.append(item)

        items = self.get_items(items_list)

        report = self.construct_single_report(items=items)
        report_list = [report]
        json = self.construct_print_json(report_list)
        return json

    def construct_header(self, block):
        page = self.get_page(1)
        data_type = self.get_type('HEADER')

        header = block['header']
        value_rows = [self.get_header_row(header)]
        value = self.get_value(value_rows)

        header = self.construct_single_section(page, data_type, value)
        return header

    def construct_data(self, block):
        page = self.get_page(1)
        data_type = self.get_type('DATA')

        value_rows = []
        block_data = block['data'].values()
        for row in block_data:
            value_rows.append(self.get_data_row(row))

            if self.is_add_aggregate_row(row):
                aggregate = block['aggregation'].pop(0)
                value_rows.extend(self.get_aggregate_row(aggregate, row))

        value = self.get_value(value_rows)
        data = self.construct_single_section(page, data_type, value)
        return data

    def is_add_aggregate_row(self, row):
        return row.get('is_end_of_page', False)

    def construct_footer(self, block):
        page = self.get_page(1)
        data_type = self.get_type('HEADER')  # type 'HEADER' helps Batch server to print this section
                                             # to every page
        footer = block['footer']
        value_rows = [self.get_footer_row(footer)]
        value = self.get_value(value_rows)

        footer = self.construct_single_section(page, data_type, value)
        return footer

    def get_header_row(self, header):
        billing_date_info = utils.date_utils.get_wareki_info(header['billing_date'])
        billing_date_year = billing_date_info['ja'] + billing_date_info['year_wareki'].zfill(2)
        billing_date_month = billing_date_info['month']

        return [
                billing_date_year,
                billing_date_month,
                str(header['registered_symbol_number'] or '').strip(),
                str(header['practitioner_full_name'] or '').strip(),
                str(header['facility_name'] or '').strip(),
                str(header['membership_number'] or '').strip(),
                str(header['insurer_jurisdiction_tcd'] or '').strip(),
                str(header['special_treatment'] or ''),
                str(header['facility_code'] or '').strip(),
                str(header['block_count']) + ' -',
            ]

    def get_data_row(self, row):
        return [
            (row['insurer_name'] or '').strip(),
            str(row['insurer_number'] or '').strip(),
            utils.add_thousand_separator(row['receipt_count_person'] or None),
            utils.add_thousand_separator(row['total_amount_person'] or None),
            utils.add_thousand_separator(row['receipt_count_family'] or None),
            utils.add_thousand_separator(row['total_amount_family'] or None),
            utils.add_thousand_separator(row['receipt_count_total'] or None),
            utils.add_thousand_separator(row['total_amount_total'] or None),
        ]

    def get_aggregate_row(self, aggregate, row):
        padding_rows = [[]] * row['remaining_rows']
        aggregate_row = [
            [
                '', '',  # Aggregate row must be same length as data row for Batch server to process
                utils.add_thousand_separator(aggregate['person_aggregate_receipt_count'] or None),
                utils.add_thousand_separator(aggregate['person_aggregate_total_amount'] or None),
                utils.add_thousand_separator(aggregate['family_aggregate_receipt_count'] or None),
                utils.add_thousand_separator(aggregate['family_aggregate_total_amount'] or None),
                utils.add_thousand_separator(aggregate['sum_aggregate_receipt_count'] or None),
                utils.add_thousand_separator(aggregate['sum_aggregate_total_amount'] or None),
            ]
        ]
        return padding_rows + aggregate_row

    def get_footer_row(self, footer):
        return [
            (footer['for_insurers_name'] or '').strip(),
        ]
