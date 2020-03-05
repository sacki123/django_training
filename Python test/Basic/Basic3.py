lst = ["Jonny Nguyễn", "Vũ Hoàng", "Nam Lê"]
lst_tamthoi = list()
for index, value in enumerate(lst):
    lst_tamthoi = value.split()
    print("%s  %s" %(lst_tamthoi[1],lst_tamthoi[0]))


