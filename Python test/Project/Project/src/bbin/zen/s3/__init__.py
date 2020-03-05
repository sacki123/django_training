#!/Commonusr/bin/python
# -*- coding: utf-8 -*-
"""
S3(BLOB) パッケージ


"""

__title__ = 'S3(BLOB) パッケージ'
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
import traceback
import datetime
from logging import getLogger

# AWS
import boto3
from boto3.session import Session

# ------------------------------------------------------------
# Variable Section
# ------------------------------------------------------------
log = getLogger(__name__)

# HungPD Add on 29/10/2018

session = boto3.session.Session()
resource_list = {}

# ------------------------------------------------------------
#  Function Section
# ------------------------------------------------------------

def set_resource(profile_name='default', aws_access_key_id=None, aws_secret_access_key=None, use_ssl=True, endpoint_url=None):
    log.debug(("change resource", profile_name, aws_access_key_id, aws_secret_access_key, use_ssl, endpoint_url,))

    try:
        # for test when setup vagrant local
        if aws_access_key_id is not None and aws_secret_access_key is not None:
            if endpoint_url is not None:
                resource_list[profile_name] = session.resource(
                    service_name='s3',
                    aws_access_key_id=aws_access_key_id,
                    aws_secret_access_key=aws_secret_access_key,
                    use_ssl=use_ssl,
                    endpoint_url=endpoint_url
                )
            else:
                # connect direct to AWS s3
                resource_list[profile_name] = session.resource(
                    service_name='s3',
                    aws_access_key_id=aws_access_key_id,
                    aws_secret_access_key=aws_secret_access_key
                )
        else:
            log.debug(("change resource error:", "missing value of variable",))
    except:
        log.error(traceback.format_exc())
        raise
    return resource_list

def get_resource(profile_name='default'):
    if len(resource_list) == 0 and profile_name :
        set_resource(profile_name)
    return resource_list[profile_name]

def bucket(name, profile_name='default'):
    log.debug((name, profile_name,))
    try:
        s3 = get_resource(profile_name)
        if check_bucket_exist(name, profile_name):
            return s3.Bucket(name)
        else:
            s3.create_bucket(
                Bucket=name,
                CreateBucketConfiguration={'LocationConstraint': 'us-east-1'}
            )
    except:
        # 例外処理
        log.error(traceback.format_exc())

        raise

def list_buckets(profile_name='default'):
    log.debug(("list_buckets", profile_name,))
    try:
        s3 = get_resource(profile_name)
        return s3.buckets.all()

    except:
        log.error(traceback.format_exc())
        raise


def check_bucket_exist(name, profile_name='default'):
    try:
        s3 = get_resource(profile_name)
        bucket_exist = s3.Bucket(name) in s3.buckets.all()
        if bucket_exist:
            return True
        return False
    except:
        log.error(traceback.format_exc())
        raise


def list_object_in_bucket(name, profile_name='default'):
    log.debug(("list_object_in_bucket", name, profile_name,))
    try:
        s3 = get_resource(profile_name)
        my_bucket = s3.Bucket(name)
        return my_bucket.objects.all()
    except:
        log.error(traceback.format_exc())
        raise

def check_object_exist(name, key, profile_name='default'):
    """
    Check one object exist or not by object name
    :param name: name of bucket
    :param key: name of object
    :param profile_name: call profile name for connect s3 ( local or from url)
    :return: True if object exist
             False if object not exist
    """
    log.debug(("check_object_exist", name, key, profile_name,))

    try:
        obj_list = list_object_in_bucket(name, profile_name)
        for obj in obj_list:
            if obj.key == key:
                return True

        return False
    except:
        log.error(traceback.format_exc())
        raise

def upload(name, key, filename, metadata=None, profile_name='default'):
    log.debug(("upload", name, key, filename, metadata, profile_name,))
    try:
        if not check_bucket_exist(name, profile_name):
            bucket(name, profile_name)

        if metadata is None:
            metadata = {
                'author': 'dev',
                'upload_date': str(datetime.datetime.now()),
                'description': '1 template or csv'
            }
        elif isinstance(metadata, dict):
            log.debug(("upload", name, key, filename, metadata, profile_name, "metadata must is dictionary",))

        s3 = get_resource(profile_name)
        body = open(filename, 'rb')
        obj = s3.Object(name, key)
        obj.put(Body=body, Metadata=metadata)
    except:
        log.error(traceback.format_exc())
        raise

def download(name, key, filename, profile_name='default'):
    """
    function use for download template or csv from s3
    :param name: name of bucket
    :param key: name of object in bucket
    :param filename: file path and name of file ex: filename=D:/31-m/bbin/zen/pdf/template_pdf/DS/ZU-P99-DS053.pdf
    :param profile_name: use for get s3 resource
    """
    log.debug(("download", name, key, filename, profile_name,))
    try:
        if check_object_exist(name, key, profile_name):
            s3 = get_resource(profile_name)
            s3.Bucket(name).download_file(key, filename)
        else:
            info = " Object '{}' not exist in bucket '{}'".format(key, name)
            log.debug(("download", name, key, filename, profile_name, info,))
    except:
        log.error(traceback.format_exc())
        raise

def del_object_from_bucket(name, key, profile_name='default'):
    log.debug(("del_object", name, key, profile_name,))
    try:
        s3 = get_resource(profile_name)
        obj = s3.Object(name, key)
        obj.delete()
    except:
        log.error(traceback.format_exc())
        raise

# HungPD Add end
# HungPD Edit on 29/10/2018
# ------------------------------------------------------------
# Function Section
# ------------------------------------------------------------

# b = s3_bucket('test', 'default', 'http://192.168.65.128:9000')
# def bucket(name, profile_name='default', url=None):
#     """
#     S3バケット取得
#     """
#
#     # ログ
#     log.debug((name, profile_name, url,))
#
#     try:
#         # セッション指定
#         session = Session(profile_name=profile_name)
#
#         # バケット取得
#         s3 = boto3.resource('s3',
#                             endpoint_url=url,
#                             config=boto3.session.Config(signature_version='s3v4')
#                             )
#         b = s3.Bucket(name)
#
#         # ログ
#         #		log.debug(b)
#
#         # 処理結果
#         return b
#     except:
#         # 例外処理
#         log.error(traceback.format_exc())
#
#         raise
#
#
# def download(name, key, filename, profile_name='default', url=None):
#     s3_bucket(name, filename, profile_name, url).download_file(key, filename)
#
#
# def upload_file(name, key, filename, profile_name='default', url=None):
#     s3_bucket(name, filename, profile_name, url).upload_file(filename, key)
# HungPD Edit end

# ------------------------------------------------------------
# Class Section
# ------------------------------------------------------------

# ------------------------------------------------------------
