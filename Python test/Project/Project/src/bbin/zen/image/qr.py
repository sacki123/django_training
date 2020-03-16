#!/Commonusr/bin/python
# -*- coding: utf-8 -*-
"""
QRコードイメージ パッケージ


"""

__title__   = 'QRコードイメージ パッケージ'
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
from pyzbar.pyzbar import decode
# QRCode
import qrcode

# ------------------------------------------------------------
## Variable Section
# ------------------------------------------------------------
log = getLogger(__name__)

# ------------------------------------------------------------
## Function Section
# ------------------------------------------------------------
def qrcode_make(text, version=6, box_size=4, border=1, fill_color="black", back_color="white"):
	"""
	QRコード生成
	"""
	# ログ
	log.debug((text, version, box_size, border, fill_color, back_color))

	try:
		qr = qrcode.QRCode(
			version=12,
			error_correction=qrcode.constants.ERROR_CORRECT_H,
			box_size=2,
			border=8
		)
		qr.add_data(text)
		qr.make()

		img = qr.make_image(fill_color=fill_color, back_color=back_color)
		return img
	except:
		# 例外処理
		log.error(traceback.format_exc())

		# 例外続行
		raise

def qrcode_decode(image, encodeing='utf-8'):
	"""
	QRコード生成
	"""
	# ログ
	log.debug((image, encodeing))

	try:
		# TODO
		data = decode(Image.open(image))
		print(data[0][0].decode(encodeing, 'ignore'))
		return data
	except:
		# 例外処理
		log.error(traceback.format_exc())

		# 例外続行
		raise


# ------------------------------------------------------------
## Class Section
# ------------------------------------------------------------

# ------------------------------------------------------------
