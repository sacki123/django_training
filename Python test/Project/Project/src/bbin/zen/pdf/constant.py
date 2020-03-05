#!/Commonusr/bin/python
# -*- coding: utf-8 -*-
"""
帳票(PDF) パッケージ


"""

__title__ = '帳票(PDF) パッケージ'
__author__ = "ExpertSoftware Inc."
__status__ = "develop"
__version__ = "0.0.0_0"
__date__ = "2018/07/27"
__license__ = ''
__desc__ = '%s Ver%s (%s)' % (__title__, __version__, __date__)

# ------------------------------------------------------------
# Import Section
# ------------------------------------------------------------
# Python
from logging import getLogger
import csv
import json
import os
import traceback

# region HungPD add 2018/11/02
# s3
from zen.s3 import check_bucket_exist
from zen.s3 import check_object_exist
from zen.s3 import download, upload

# endregion HungPD add 2018/11/02

# ------------------------------------------------------------
# Variable Section
# ------------------------------------------------------------
log = getLogger(__name__)

# Current directory Path
DIR_NAME = os.path.dirname(__file__)

# Font Path
FONT_PATH = os.path.join(DIR_NAME, './config/ipamjm.ttf')
FONT_NAME = 'ipamjm'
FONT_SIZE_DEFAULT = 12

# Config directory Path
CONFIG_FILE_DIRECTORY = os.path.join(DIR_NAME, './config/')

CSV_FILE_DIRECTORY = os.path.join(DIR_NAME, './csvdata/')

# Template directory Path
TEMPLATE_FILE_DIRECTORY = os.path.join(DIR_NAME, './template_pdf/')

# Output directory Path
OUTPUT_PDF_FILE_DIRECTORY = os.path.join(DIR_NAME, './output_pdf/')

# kinou-bango field name
KINOU_BANGO = "kinou-bango"

# Char Spacing setting
CHAR_SPACING = 1.7

# Debug mode
DEBUG_MODE = True

# default position of label
LABEL_DEFAULT_POSITION = {
    "PDF": [504, 792],
    "PDF_ROTATE": [795, 565],
    "EXCEL": [0, 10],
}

STYLE_BORDER_DATA_PDF = {
    'simple_dashes': 'simple_dashes',
    'dots': 'dots',
    'complex_pattern': 'complex_pattern'
}
# Style alignment right
ALIGN_RIGHT = "right"
# Style alignment left
ALIGN_LEFT = "left"
# Style alignment center
ALIGN_CENTER = "distributed"

# SETUP PRINT MODE
ACROBAT_READER = 'C:\Program Files (x86)\Adobe\Acrobat Reader DC\Reader\AcroRd32.exe'
TWO_SIDED_MODE = False

DEFAULT_LINE_OPTIONS = {
    "LINE_TYPE": "SOLID"
}

DEFAULT_LINE_SPACING = 20
DEFAULT_SECTION_SPACING = 30

# Setting font in xlsx
FONT_SETTING = {
    "name": "Calibri",
    "size": 11,
    "bold": False,
    "italic": False,
    "vertAlign": None,
    "underline": None,
    "strike": False,
    "color": "FF000000",
}

PATTERN_FILL_SETTING = {
    "fill_type": None,
    "start_color": "FFFFFFFF",
    "end_color": "FF000000",
}

BORDER_SETTING = {
    "left": {
        "border_style": None,
        "color": "FF000000",
    },
    "right": {
        "border_style": None,
        "color": "FF000000",
    },
    "top": {
        "border_style": None,
        "color": "FF000000",
    },
    "bottom": {
        "border_style": None,
        "color": "FF000000",
    },
    "diagonal": {
        "border_style": None,
        "color": "FF000000",
    },
    "diagonal_direction": 0,
    "outline": {
        "border_style": None,
        "color": "FF000000",
    },
    "vertical": {
        "border_style": None,
        "color": "FF000000",
    },
    "horizontal": {
        "border_style": None,
        "color": "FF000000",
    },
}

# set default font for PDF file
LEN_TEXT_DEFAULT = 100
CHAR_SPACE_DEFAULT = 1.7
ALIGNMENT_DEFAULT = "left"

# set default box for PDF file
MODE_FILL_DEFAULT = 0
MODE_STROKE_DEFAULT = 1
STROKE_COLOR_DEFAULT = "black"
LINE_WIDTH_DEFAULT = 3
BORDER_DASH_DEFAULT = [0, 0, 0]
TEXT_COLOR_DEFAULT = "black"

ALIGNMENT_SETTING = {
    "horizontal": "general",
    "vertical": "bottom",
    "text_rotation": 0,
    "wrap_text": False,
    "shrink_to_fit": False,
    "indent": 0,
}
NUMBER_FORMAT_SETTING = {
    "number_format": "General",
}
PROTECTION_SETTING = {
    "locked": True,
    "hidden": False,
}

MAX_SECTION_DEFAULT = 2
# set default font for PDF
LEN_TEXT = 100
CHAR_SPACE = 1.7
ALIGNMENT = "left"
COLOR_DEFAULT = "black"
BORDER_DEFAULT = False
BORDER_COLOR_DEFAULT = "black"
BORDER_THICKNESS_DEFAULT = 1
BORDER_STYLE_DEFAULT = [1, 0]

# result
RESULT_SUCCESS = "0"
RESULT_ERROR = "1 : Error "

# error id code
# get template file
ERROR_001 = "S001"
# read file fail
ERROR_002 = "S002"
# fill data to template fail
ERROR_003 = "S003"
# get json file fail
ERROR_004 = "S004"

# error list
error_list = []
error_mode = False
error_not_define = False
json_mode = True

# region HungPD add 2018/11/02
"""
    because program not have define s3 server, bucket name and temp download directory,
    so I set default variable to function upload
"""
# TODO get profile_name, bucket name, temp_download_dir from config
temp_download_dir = DIR_NAME + "/s3_temp_dir/"
s3_bucket = 'default'

# endregionHungPD add 2018/11/02


def read_json(path_json):
    """
    Load data from json
    :param path_json: path file
    :return: content of json
    """
    try:
        with open(path_json, "r", encoding="utf-8") as json_data:
            data = json.load(json_data)
            return data
    except:
        get_error(ERROR_004)


def get_data_by_kinoubango(file_path):
    """
    Reading csv file
    :param file_path: path of file
    :return: list data from csv file
    """
    with open(file_path, "r", encoding='utf8') as f:
        cr = csv.reader(f, delimiter=",")
        lst_data = list(cr)
        lst_data.pop(0)
        return lst_data


def set_output_file_name_by_kinoubango(kinoubango, category, activity_code):
    """
    Set output file name by kinou bango
    :param kinoubango: number code of output file
    :param category: category that contain output file
    :param activity_code: Code of function Example : P99, P02 ...
    """
    if kinoubango.isdigit():
        file_name = "%s%s/%s/ZU-%s-%s%03d" % (OUTPUT_PDF_FILE_DIRECTORY, activity_code, category, activity_code, category, int(kinoubango))
    else:
        file_name = "%s%s/%s/ZU-%s-%s%s" % (OUTPUT_PDF_FILE_DIRECTORY, activity_code, category, activity_code, category, kinoubango)
    return file_name


def get_template_file_by_kinoubango(kinoubango, category, activity_code, profile_name):
    """
    Get excel template file name by kinou bango
    :param profile_name: all s3 information
    :param kinoubango: function number
    :param activity_code: Code of function Example : P99, P02 ...
    :param category: category of module
    """

    if kinoubango.isdigit():
        file_name_xls = "%s%s/%s/ZU-%s-%s%03d.xls" % (TEMPLATE_FILE_DIRECTORY, activity_code, category, activity_code, category, int(kinoubango))
        file_name_xlsx = "%s%s/%s/ZU-%s-%s%03d.xlsx" % (TEMPLATE_FILE_DIRECTORY, activity_code, category, activity_code, category, int(kinoubango))
        file_name_pdf = "%s%s/%s/ZU-%s-%s%03d.pdf" % (TEMPLATE_FILE_DIRECTORY, activity_code, category, activity_code, category, int(kinoubango))
    else:
        file_name_xls = "%s%s/%s/ZU-%s-%s%s.xls" % (TEMPLATE_FILE_DIRECTORY, activity_code, category, activity_code, category, kinoubango)
        file_name_xlsx = "%s%s/%s/ZU-%s-%s%s.xlsx" % (TEMPLATE_FILE_DIRECTORY, activity_code, category, activity_code, category, kinoubango)
        file_name_pdf = "%s%s/%s/ZU-%s-%s%s.pdf" % (TEMPLATE_FILE_DIRECTORY, activity_code, category, activity_code, category, kinoubango)
    if os.path.exists(file_name_xls) and os.path.exists(file_name_xlsx):
        log.warning("Existing .xls file and .xlsx file in template folder")
        return file_name_xls
    elif os.path.exists(file_name_xls):
        return file_name_xls
    elif os.path.exists(file_name_xlsx):
        return file_name_xlsx
    elif os.path.exists(file_name_pdf):
        return file_name_pdf
    # region HungPD add 2018/11/01: download template xls, xlsx or pdf from s3
    elif check_bucket_exist(s3_bucket, profile_name):
        obj_name = None
        if check_object_exist(s3_bucket, os.path.basename(file_name_xls), profile_name):
            obj_name = os.path.basename(file_name_xls)
        elif check_object_exist(s3_bucket, os.path.basename(file_name_xlsx), profile_name):
            obj_name = os.path.basename(file_name_xlsx)
        elif check_object_exist(s3_bucket, os.path.basename(file_name_pdf), profile_name):
            obj_name = os.path.basename(file_name_pdf)
        else:
            # log.error(traceback.format_exc())
            # log.error("Template file is not exist")
            get_error(ERROR_001)

        # create directory download if not exist
        if not os.path.exists(temp_download_dir):
            os.makedirs(temp_download_dir, exist_ok=True)
        # download file from s3
        if obj_name is not None:
            temp_download_file = temp_download_dir + obj_name
            download(s3_bucket, obj_name, temp_download_file, profile_name)
            return temp_download_file

    # endregion HungPD add 2018/11/01
    else:
        log.error(traceback.format_exc())
        log.error("Template file is not exist")


def get_json_file_by_kinoubango(kinoubango, category, activity_code):
    """
    Get CSV file name by kinou bango
    :param kinoubango: number code of CSV file
    :param category: category that contain CSV file
    :param activity_code: Code of function Example : P99, P02 ...
    """
    try:
        if kinoubango.isdigit():
            file_name = "%s%s/%s/ZU-%s-%s%03d.json" % (CSV_FILE_DIRECTORY, activity_code, category, activity_code, category, int(kinoubango))
        else:
            file_name = "%s%s/%s/ZU-%s-%s%s.json" % (CSV_FILE_DIRECTORY, activity_code, category, activity_code, category, kinoubango)
        return file_name
    except:
        get_error(ERROR_004)


def get_error(error):
    """
    Get error
    :param error: error in fill data processing
    """
    if error == "S001" and "S001" not in error_list and "S002" not in error_list and "S003" not in error_list and "S004" not in error_list:
        error_list.append(error)
    elif error == "S002" and "S001" not in error_list and "S002" not in error_list and "S003" not in error_list and "S004" not in error_list:
        error_list.append(error)
    elif error == "S003" and "S001" not in error_list and "S002" not in error_list and "S003" not in error_list and "S004" not in error_list:
        error_list.append(error)
    elif error == "S004" and "S001" not in error_list and "S002" not in error_list and "S003" not in error_list and "S004" not in error_list:
        error_list.append(error)
    return error_list


def print_error(error_list):
    """
    Print error
    :param error_list: list of errors in fill data processing
    """
    if error_not_define == False:
        if len(error_list) > 0:
            print(RESULT_ERROR, error_list)
        else:
            print(RESULT_SUCCESS)


if __name__ == '__main__':
    pass
