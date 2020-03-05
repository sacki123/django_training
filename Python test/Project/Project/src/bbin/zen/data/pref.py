#!/Commonusr/bin/python
# -*- coding: utf-8 -*-
"""
都道府県データ パッケージ


"""

__title__   = '都道府県データ パッケージ'
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
from logging import getLogger

# ------------------------------------------------------------
## Variable Section
# ------------------------------------------------------------
log = getLogger(__name__)

PREF_JA = {
'HOKKAIDO': {'code': 1, 'ja': u'北海道', 'kana': u'ほっかいどう', 'en': 'hokkaido'},
'AOMORI': {'code': 2, 'ja': u'青森県', 'kana': u'あおもり', 'en': 'aomori'},
'IWATE': {'code': 3, 'ja': u'岩手県', 'kana': u'いわて', 'en': 'iwate'},
'MIYAGI': {'code': 4, 'ja': u'宮城県', 'kana': u'みやぎ', 'en': 'miyagi'},
'AKITA': {'code': 5, 'ja': u'秋田県', 'kana': u'あきた', 'en': 'akita'},
'YAMAGATA': {'code': 6, 'ja': u'山形県', 'kana': u'やまがた', 'en': 'yamagata'},
'FUKUSHIMA': {'code': 7, 'ja': u'福島県', 'kana': u'ふくしま', 'en': 'fukushima'},
'IBARAKI': {'code': 8, 'ja': u'茨城県', 'kana': u'いばらき', 'en': 'ibaraki'},
'TOCHIGI': {'code': 9, 'ja': u'栃木県', 'kana': u'とちぎ', 'en': 'tochigi'},
'GUNMA': {'code': 10, 'ja': u'群馬県', 'kana': u'ぐんま', 'en': 'gunma'},
'SAITAMA': {'code': 11, 'ja': u'埼玉県', 'kana': u'さいたま', 'en': 'saitama'},
'CHIBA': {'code': 12, 'ja': u'千葉県', 'kana': u'ちば', 'en': 'chiba'},
'TOKYO': {'code': 13, 'ja': u'東京都', 'kana': u'とうきょう', 'en': 'tokyo'},
'KANAGAWA': {'code': 14, 'ja': u'神奈川県', 'kana': u'かながわ', 'en': 'kanagawa'},
'NIIGATA': {'code': 15, 'ja': u'新潟県', 'kana': u'にいがた', 'en': 'niigata'},
'TOYAMA': {'code': 16, 'ja': u'富山県', 'kana': u'とやま', 'en': 'toyama'},
'ISHIKAWA': {'code': 17, 'ja': u'石川県', 'kana': u'いしかわ', 'en': 'ishikawa'},
'FUKUI': {'code': 18, 'ja': u'福井県', 'kana': u'ふくい', 'en': 'fukui'},
'YAMANASHI': {'code': 19, 'ja': u'山梨県', 'kana': u'やまなし', 'en': 'yamanashi'},
'NAGANO': {'code': 20, 'ja': u'長野県', 'kana': u'ながの', 'en': 'nagano'},
'GIFU': {'code': 21, 'ja': u'岐阜県', 'kana': u'ぎふ', 'en': 'gifu'},
'SHIZUOKA': {'code': 22, 'ja': u'静岡県', 'kana': u'しずおか', 'en': 'shizuoka'},
'AICHI': {'code': 23, 'ja': u'愛知県', 'kana': u'あいち', 'en': 'aichi'},
'MIE': {'code': 24, 'ja': u'三重県', 'kana': u'みえ', 'en': 'mie'},
'SHIGA': {'code': 25, 'ja': u'滋賀県', 'kana': u'しが', 'en': 'shiga'},
'KYOTO': {'code': 26, 'ja': u'京都府', 'kana': u'きょうと', 'en': 'kyoto'},
'OSAKA': {'code': 27, 'ja': u'大阪府', 'kana': u'おおさか', 'en': 'osaka'},
'HYOGO': {'code': 28, 'ja': u'兵庫県', 'kana': u'ひょうご', 'en': 'hyogo'},
'NARA': {'code': 29, 'ja': u'奈良県', 'kana': u'なら', 'en': 'nara'},
'WAKAYAMA': {'code': 30, 'ja': u'和歌山県', 'kana': u'わやかま', 'en': 'wakayama'},
'TOTTORI': {'code': 31, 'ja': u'鳥取県', 'kana': u'とっとり', 'en': 'tottori'},
'SHIMANE': {'code': 32, 'ja': u'島根県', 'kana': u'しまね', 'en': 'shimane'},
'OKAYAMA': {'code': 33, 'ja': u'岡山県', 'kana': u'おかやま', 'en': 'okayama'},
'HIROSHIMA': {'code': 34, 'ja': u'広島県', 'kana': u'ひろしま', 'en': 'hiroshima'},
'YAMAGUCHI': {'code': 35, 'ja': u'山口県', 'kana': u'やまぐち', 'en': 'yamaguchi'},
'TOKUSHIMA': {'code': 36, 'ja': u'徳島県', 'kana': u'とくしま', 'en': 'tokushima'},
'KAGAWA': {'code': 37, 'ja': u'香川県', 'kana': u'かがわ', 'en': 'kagawa'},
'EHIME': {'code': 38, 'ja': u'愛媛県', 'kana': u'えひめ', 'en': 'ehime'},
'KOCHI': {'code': 39, 'ja': u'高知県', 'kana': u'こうち', 'en': 'kochi'},
'FUKUOKA': {'code': 40, 'ja': u'福岡県', 'kana': u'ふくおか', 'en': 'fukuoka'},
'SAGA': {'code': 41, 'ja': u'佐賀県', 'kana': u'さが', 'en': 'saga'},
'NAGASAKI': {'code': 42, 'ja': u'長崎県', 'kana': u'ながさき', 'en': 'nagasaki'},
'KUMAMOTO': {'code': 43, 'ja': u'熊本県', 'kana': u'くまもと', 'en': 'kumamoto'},
'OITA': {'code': 44, 'ja': u'大分県', 'kana': u'おおいた', 'en': 'oita'},
'MIYAZAKI': {'code': 45, 'ja': u'宮崎県', 'kana': u'みやざき', 'en': 'miyazaki'},
'KAGOSHIMA': {'code': 46, 'ja': u'鹿児島県', 'kana': u'かごしま', 'en': 'kagoshima'},
'OKINAWA': {'code': 47, 'ja': u'沖縄県', 'kana': u'おきなわ', 'en': 'okinawa'}
}

# ------------------------------------------------------------
## Function Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## Class Section
# ------------------------------------------------------------

# ------------------------------------------------------------
