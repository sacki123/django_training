#!/Commonusr/bin/python
# -*- coding: utf-8 -*-
"""
帳票(PDF) パッケージ


"""

__title__ = '帳票(PDF) パッケージ'
__author__ = "ExpertSoftware Inc."
__status__ = "develop"
__version__ = "0.0.0_0"
__date__ = "2019/08/08"
__license__ = ''
__desc__ = '%s Ver%s (%s)' % (__title__, __version__, __date__)

# ------------------------------------------------------------
## Import Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## Variable Section
# ------------------------------------------------------------

char_space = 0
max_section_loop_count = 13

# Position information on Page 01
ZU_P02_PB001_PAGE_01_POSITION = [
    [
        {
            "TYPE": "DATA",
            "POSITION": [
                [701, 530]
            ],
            "LEN_TEXT": 100,
            "CHAR_SPACE": char_space,
            "FONT_SIZE": 16,
            "COLOR": "Black",
            "ALIGNMENT": "right",
        }
    ],
    [
        {
            "TYPE": "DATA",
            "MAX_SECTION_LOOP_COUNT": max_section_loop_count,
            "FIRST_LINE_SPACE": 36,
            "POSITION": [
                [36, 485]
            ],
            "LEN_TEXT": 136,
            "CHAR_SPACE": char_space,
            "FONT_SIZE": 11,
            "COLOR": "Black",
            "ALIGNMENT": "left",
        },
        {
            "TYPE": "DATA",
            "MAX_SECTION_LOOP_COUNT": max_section_loop_count,
            "FIRST_LINE_SPACE": 36,
            "POSITION": [
                [81, 485]
            ],
            "LEN_TEXT": 100,
            "CHAR_SPACE": char_space,
            "FONT_SIZE": 11,
            "COLOR": "Black",
            "ALIGNMENT": "left",
        },
        {
            "TYPE": "DATA",
            "MAX_SECTION_LOOP_COUNT": max_section_loop_count,
            "FIRST_LINE_SPACE": 36,
            "POSITION": [
                [140, 485]
            ],
            "LEN_TEXT": 100,
            "CHAR_SPACE": char_space,
            "FONT_SIZE": 11,
            "COLOR": "Black",
            "ALIGNMENT": "right",
        },
        {
            "TYPE": "DATA",
            "MAX_SECTION_LOOP_COUNT": max_section_loop_count,
            "FIRST_LINE_SPACE": 36,
            "POSITION": [
                [201, 485]
            ],
            "LEN_TEXT": 100,
            "CHAR_SPACE": char_space,
            "FONT_SIZE": 11,
            "COLOR": "Black",
            "ALIGNMENT": "right",
        },
        {
            "TYPE": "DATA",
            "MAX_SECTION_LOOP_COUNT": max_section_loop_count,
            "FIRST_LINE_SPACE": 36,
            "POSITION": [
                [224, 485]
            ],
            "LEN_TEXT": 100,
            "CHAR_SPACE": char_space,
            "FONT_SIZE": 11,
            "COLOR": "Black",
            "ALIGNMENT": "right",
        },
        {
            "TYPE": "DATA",
            "MAX_SECTION_LOOP_COUNT": max_section_loop_count,
            "FIRST_LINE_SPACE": 36,
            "POSITION": [
                [250, 485]
            ],
            "LEN_TEXT": 100,
            "CHAR_SPACE": char_space,
            "FONT_SIZE": 11,
            "COLOR": "Black",
            "ALIGNMENT": "right",
        },
        {
            "TYPE": "DATA",
            "MAX_SECTION_LOOP_COUNT": max_section_loop_count,
            "FIRST_LINE_SPACE": 36,
            "POSITION": [
                [274, 485]
            ],
            "LEN_TEXT": 100,
            "CHAR_SPACE": char_space,
            "FONT_SIZE": 11,
            "COLOR": "Black",
            "ALIGNMENT": "right",
        },
        {
            "TYPE": "DATA",
            "MAX_SECTION_LOOP_COUNT": max_section_loop_count,
            "FIRST_LINE_SPACE": 36,
            "POSITION": [
                [334, 485]
            ],
            "LEN_TEXT": 100,
            "CHAR_SPACE": char_space,
            "FONT_SIZE": 11,
            "COLOR": "Black",
            "ALIGNMENT": "right",
        },
        {
            "TYPE": "DATA",
            "MAX_SECTION_LOOP_COUNT": max_section_loop_count,
            "FIRST_LINE_SPACE": 36,
            "POSITION": [
                [444, 485]
            ],
            "LEN_TEXT": 100,
            "CHAR_SPACE": char_space,
            "FONT_SIZE": 11,
            "COLOR": "Black",
            "ALIGNMENT": "right",
        },
        {
            "TYPE": "DATA",
            "MAX_SECTION_LOOP_COUNT": max_section_loop_count,
            "FIRST_LINE_SPACE": 36,
            "POSITION": [
                [553, 485]
            ],
            "LEN_TEXT": 100,
            "CHAR_SPACE": char_space,
            "FONT_SIZE": 11,
            "COLOR": "Black",
            "ALIGNMENT": "right",
        },
        {
            "TYPE": "DATA",
            "MAX_SECTION_LOOP_COUNT": max_section_loop_count,
            "FIRST_LINE_SPACE": 36,
            "POSITION": [
                [600, 485]
            ],
            "LEN_TEXT": 100,
            "CHAR_SPACE": char_space,
            "FONT_SIZE": 11,
            "COLOR": "Black",
            "ALIGNMENT": "right",
        },
        {
            "TYPE": "DATA",
            "MAX_SECTION_LOOP_COUNT": max_section_loop_count,
            "FIRST_LINE_SPACE": 36,
            "POSITION": [
                [637, 485]
            ],
            "LEN_TEXT": 100,
            "CHAR_SPACE": char_space,
            "FONT_SIZE": 11,
            "COLOR": "Black",
            "ALIGNMENT": "right",
        },
        {
            "TYPE": "DATA",
            "MAX_SECTION_LOOP_COUNT": max_section_loop_count,
            "FIRST_LINE_SPACE": 36,
            "POSITION": [
                [674, 485]
            ],
            "LEN_TEXT": 100,
            "CHAR_SPACE": char_space,
            "FONT_SIZE": 11,
            "COLOR": "Black",
            "ALIGNMENT": "right",
        },
        {
            "TYPE": "DATA",
            "MAX_SECTION_LOOP_COUNT": max_section_loop_count,
            "FIRST_LINE_SPACE": 36,
            "POSITION": [
                [709, 485]
            ],
            "LEN_TEXT": 100,
            "CHAR_SPACE": char_space,
            "FONT_SIZE": 11,
            "COLOR": "Black",
            "ALIGNMENT": "right",
        },
        {
            "TYPE": "DATA",
            "MAX_SECTION_LOOP_COUNT": max_section_loop_count,
            "FIRST_LINE_SPACE": 36,
            "POSITION": [
                [736, 485]
            ],
            "LEN_TEXT": 100,
            "CHAR_SPACE": char_space,
            "FONT_SIZE": 11,
            "COLOR": "Black",
            "ALIGNMENT": "right",
        },
        {
            "TYPE": "DATA",
            "MAX_SECTION_LOOP_COUNT": max_section_loop_count,
            "FIRST_LINE_SPACE": 36,
            "POSITION": [
                [760, 485]
            ],
            "LEN_TEXT": 100,
            "CHAR_SPACE": char_space,
            "FONT_SIZE": 11,
            "COLOR": "Black",
            "ALIGNMENT": "right",
        },
        {
            "TYPE": "DATA",
            "MAX_SECTION_LOOP_COUNT": max_section_loop_count,
            "FIRST_LINE_SPACE": 36,
            "POSITION": [
                [786, 485]
            ],
            "LEN_TEXT": 100,
            "CHAR_SPACE": char_space,
            "FONT_SIZE": 11,
            "COLOR": "Black",
            "ALIGNMENT": "right",
        },
    ],
    [
        {
            "TYPE": "DATA",
            "POSITION": [
                [532, 75]
            ],
            "LEN_TEXT": 100,
            "CHAR_SPACE": char_space,
            "FONT_SIZE": 18,
            "COLOR": "Black",
            "ALIGNMENT": "right",
        },
    ]
]

ZU_P02_PB001_PAGE_NUMBER_POSITION = {
    "TYPE": "DATA",
    "POSITION": [
        [783, 530]
    ],
    "LEN_TEXT": 100,
    "CHAR_SPACE": char_space,
    "FONT_SIZE": 11,
    "COLOR": "Black",
    "ALIGNMENT": "left",
}

# ------------------------------------------------------------
## Function Section
# ------------------------------------------------------------

def get_pos_conf():
    return [ZU_P02_PB001_PAGE_01_POSITION], [ZU_P02_PB001_PAGE_NUMBER_POSITION]

# ------------------------------------------------------------
## Class Section
# ------------------------------------------------------------
