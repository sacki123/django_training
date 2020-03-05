# -*- coding: utf-8 -*-
# (C) 2018 ExpertSoftware, Inc.
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""
    # DBUtil Module
    # This module implements all functions working on Database
    # :copyright: (c) 2018 by ExpertSoftware, Inc.
    # :license: Apache 2.0, see LICENSE for more details.
"""
# ------------------------------------------------------------
# Import Section
# Python
import traceback
from logging import getLogger
# Third Party
import pymysql
from configparser import ConfigParser
# Specific Module
from constants import DB

# ------------------------------------------------------------
# Variable Section
# ------------------------------------------------------------
log = getLogger(__name__)


# ------------------------------------------------------------

# Implement Section


class DBUtil:
    """
    # DBUtil is a suite of Python modules allowing to connect in a safe and efficient way
    # between a threaded Python application and a database.
    """
    
    def __init__(self):
        """
        Init an object of DBUntil
        """
        pass
    
    @staticmethod
    def read_db_config(filename='config.ini', section='MariaDB'):
        """
        Read database configuration file and return a dictionary object
        :param filename: name of the configuration file
        :param section: section of database configuration
        :return: a dictionary of database parameters
        """
        try:
            # create parser and read ini configuration file
            parser = ConfigParser()
            parser.read(filename)
            # get section, default to MariaDB
            db = {}
            if parser.has_section(section):
                items = parser.items(section)
                for item in items:
                    db[item[0]] = item[1]
                return db
            else:
                raise Exception('{0} not found in the {1} file'.format(section, filename))
        except RuntimeError:
            # 例外処理
            log.error(traceback.format_exc())
    
    @classmethod
    def createMariaDBConnection(cls):
        """
        Connect to Maria DB
        :return: Connection Object that connect to DB
        """
        dbInfo = cls.read_db_config()
        try:
            # Connect to the database
            connection = pymysql.connect(host=dbInfo["host"], user=dbInfo["user"], password=dbInfo["password"],
                                         db=dbInfo["database"], charset=DB.UTF8MB4_CHARSET,
                                         cursorclass=pymysql.cursors.DictCursor)
            return connection
        except Exception as err:
            # 例外処理
            log.error(traceback.format_exc(err))


# ------------------------------------------------------------

# Main Section


if __name__ == '__main__':
    pass

