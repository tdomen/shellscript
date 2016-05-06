#coding:utf-8

import os
import time
from datetime import datetime as dt
from operator import itemgetter
import csv

row_data = ['a','a','a','a','a']
data = ['a','a']
datalist = []
namelist = []

f = open("log.csv",'r')
chardata = f.readline()
chardata = chardata.strip()
chardata = chardata.strip(",")
row_data = chardata.split(",")

while chardata:
    flag = 0
    flag_name = 0
    chardata = f.readline()
    chardata = chardata.strip()
    chardata = chardata.strip(",")
    row_data = chardata.split(",")
    if row_data[0] != "/起動" and row_data[0] != '':
        charday = row_data[0]
        
        try:
            day = dt.strptime(charday, '%Y/%m/%d %H:%M:%S')
        except ValueError:
            day = dt.strptime(charday, '%Y/%m/%d %H:%M')
        
        charday = day.strftime('%Y/%m/%d')
        name = row_data[2]
        if row_data[3] != "離席" and row_data[3] != "前回座席" and row_data[3] != "強制退席":
            status = row_data[3]
            data[0] = charday
            data[1] = name
            for j in datalist:
                if charday == j[0] and name == j[1]:
                    flag = 1
            if flag == 0:
                datalist.append([charday,name])
            for i in namelist:
                if name == i[0]:
                    flag_name = 1
            if flag_name == 0:
                namelist.append([name,1])

datalist.sort(key=itemgetter(0),reverse=True)

for i in datalist:
    for j in namelist:
        if i[1] == j[0]:
            tmp = int(j[1])
            tmp += 1
            j[1] = int(tmp)

namelist.sort(key=itemgetter(1),reverse=True)

f = open('list.csv','ab')
dataWriter = csv.writer(f)
dataWriter.writerows(namelist)
f.close()
