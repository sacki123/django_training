from zen.db.doclike_mysql import Doclike_mysql

config = {
        "USER"    : "zen",
        "PASSWORD": "zen",
        "HOST"    : "storage-mariadb-batch",
        "NAME"    : "zen_report"
}
c = Doclike_mysql(config)

table_name = "PRINT_SETTING"
c.set_table_name(table_name)
value = {
    'OPTION': {
        'CPN': '1', 'COLT': 'NO', 'DUP': 'NO', 'STPL': 'NO', 'PNCH': 'NO', 'OT': 'CT2', 'IT': 'AUTO', 'SIZ': 'NUL', 'MED': 'NUL', 'DEL': 'IMP', 'PPUSR': '', 'HOUR': '1', 'MIN': '1', 'SPUSR': '', 'SPID': '', 'RSPID': ''
    }
}
print(c.insert_doc_one(value))