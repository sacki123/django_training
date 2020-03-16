#!/Commonusr/bin/python
# -*- coding: utf-8 -*-
"""
帳票(PDF) パッケージ


"""

__title__   = '帳票(PDF) パッケージ'
__author__  = "ExpertSoftware Inc."
__status__  = "develop"
__version__ = "0.0.0_0"
__date__    = "2018/07/27"
__license__ = ''
__desc__    = '%s Ver%s (%s)' % (__title__, __version__, __date__)

# ------------------------------------------------------------
## Import Section
# ------------------------------------------------------------
# Python
import traceback
from logging import getLogger

# PyPDF
import PyPDF2
# ------------------------------------------------------------
## Variable Section
# ------------------------------------------------------------
log = getLogger(__name__)

# Position information on Page 01
ZU_P02_JZ002_PAGE_01_POSITION = [
    [
         {
            "TYPE": "DATA",
            "POSITION": [
                [6.14* 72, 7.78 * 72]
            ],
            "LEN_TEXT": 100,
            "CHAR_SPACE": 1.5,
            "FONT_SIZE": 14,
            "ALIGNMENT": "left",
        }
    ],
    [
        {
            "TYPE": "DATA",
            "MAX_SECTION": 6,
            "FIRST_LINE_SPACE":15,
            "POSITION": [
                [0.62* 72, 7.50 * 72]
            ],
            "LEN_TEXT": 100,
            "CHAR_SPACE": 1.7,
            "FONT_SIZE": 10,
            "ALIGNMENT": "left",
        },
        {
            "TYPE": "DATA",
            "MAX_SECTION": 6,
            "FIRST_LINE_SPACE":15,
            "POSITION": [
                [1.20*72, 7.53 * 72]
            ],
            "LEN_TEXT": 100,
            "CHAR_SPACE": 1.7,
            "FONT_SIZE": 10,
            "ALIGNMENT": "left",
        },
        {
            "TYPE": "DATA",
            "MAX_SECTION": 6,
            "FIRST_LINE_SPACE":15,
            "POSITION": [
                [2.38*72, 7.53 * 72]
            ],
            "LEN_TEXT": 100,
            "CHAR_SPACE": 1.7,
            "FONT_SIZE": 10,
            "ALIGNMENT": "left",
        },
        {
            "TYPE": "DATA",
            "MAX_SECTION": 6,
            "FIRST_LINE_SPACE":15,
            "POSITION": [
                [2.84*72, 7.53*72]
            ],
            "LEN_TEXT": 100,
            "CHAR_SPACE": 1.7,
            "FONT_SIZE": 10,
            "ALIGNMENT": "left",
        },
        {
            "TYPE": "DATA",
            "MAX_SECTION": 6,
            "FIRST_LINE_SPACE":15,
            "POSITION": [
                [3.08*72, 7.53*72]
            ],
            "LEN_TEXT": 100,
            "CHAR_SPACE": 1.7,
            "FONT_SIZE": 10,
            "ALIGNMENT": "left",
        },
        {
            "TYPE": "DATA",
            "MAX_SECTION": 6,
            "FIRST_LINE_SPACE":15,
            "POSITION": [
                [4.09*72, 7.53*72]
            ],
            "LEN_TEXT": 100,
            "CHAR_SPACE": 1.7,
            "FONT_SIZE": 10,
            "ALIGNMENT": "left",
        },
        {
            "TYPE": "DATA",
            "MAX_SECTION": 6,
            "FIRST_LINE_SPACE":15,
            "POSITION": [
                [4.40*72, 7.53*72]
            ],
            "LEN_TEXT": 100,
            "CHAR_SPACE": 1.7,
            "FONT_SIZE": 10,
            "ALIGNMENT": "left",
        },
        {
            "TYPE": "DATA",
            "MAX_SECTION": 6,
            "FIRST_LINE_SPACE":15,
            "POSITION": [
                [4.95*72, 7.53*72]
            ],
            "LEN_TEXT": 100,
            "CHAR_SPACE": 1.7,
            "FONT_SIZE": 10,
            "ALIGNMENT": "left",
        },
        {
            "TYPE": "DATA",
            "MAX_SECTION": 6,
            "FIRST_LINE_SPACE":15,
            "POSITION": [
                [6.30*72, 7.53*72]
            ],
            "LEN_TEXT": 100,
            "CHAR_SPACE": 1.7,
            "FONT_SIZE": 10,
            "ALIGNMENT": "left",
        },
        {
            "TYPE": "DATA",
            "MAX_SECTION": 6,
            "FIRST_LINE_SPACE":15,
            "POSITION": [
                [6.60*72, 7.53*72]
            ],
            "LEN_TEXT": 100,
            "CHAR_SPACE": 1.7,
            "FONT_SIZE": 10,
            "ALIGNMENT": "left",
        },
        {
            "TYPE": "DATA",
            "MAX_SECTION": 6,
            "FIRST_LINE_SPACE":15,
            "POSITION": [
                [7.30*72, 7.53*72]
            ],
            "LEN_TEXT": 100,
            "CHAR_SPACE": 1.7,
            "FONT_SIZE": 10,
            "ALIGNMENT": "left",
        },
        {
            "TYPE": "DATA",
            "MAX_SECTION": 6,
            "FIRST_LINE_SPACE":15,
            "POSITION": [
                [9.08*72, 7.53*72]
            ],
            "LEN_TEXT": 100,
            "CHAR_SPACE": 1.7,
            "FONT_SIZE": 10,
            "ALIGNMENT": "left",
        }
    ]
]

# ------------------------------------------------------------
## Function Section
# ------------------------------------------------------------
def execute(command):
    # ログ
    log.debug(command)

    try:
        # initialize position list in file PDF
        pos_list = [ZU_P02_JZ002_PAGE_01_POSITION]
        data = command.files.get_data_on_json(pos_list)
        index = 1
        for row in data:
            # initialize PdfFileWriter
            pdf_file_writer = PyPDF2.PdfFileWriter()
            # initialize object to create PDF file
            output_pdf = open(command.files.file_output_name + "_%03d.pdf" % int(index), "wb")
            # definition template
            for pageData in row:
                template = PyPDF2.PdfFileReader(open(command.files.template, "rb"))
                page = pageData[2]
                # Creating pages and adding page content
                pdf_file_writer.addPage(command.files.create_page_ZU_P99_JA(template, page, pageData[1], pageData[0]))
            # Writing content and create PDF file
            pdf_file_writer.write(output_pdf)
            output_pdf.close()
            index += 1
    except:
        # 例外処理
        log.error(traceback.format_exc())

    # ログ.
    log.info(command)
    return 1

# ------------------------------------------------------------
## Class Section
# ------------------------------------------------------------

# ------------------------------------------------------------
