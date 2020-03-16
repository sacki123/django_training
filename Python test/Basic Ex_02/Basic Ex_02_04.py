ip = input(" Nhập vào một số chuỗi có chứa dấu ',': ")
def taolist(para):
    """
    Hàm trả về một list tách ra từ một chuỗi có chưa dấu ","
    :param param1: Một string là tham số được truyền vào có dấu ',' 
    :return: Trả về list các phần tử trong chuỗi các nhau bởi dấu ','
    """
    lst = list()
    lst = para.split(",")
    return lst
a = taolist(ip)    
print(a)
