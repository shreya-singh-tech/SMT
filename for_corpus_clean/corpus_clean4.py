#for cleaning the :6 : in files
from sys import argv
import io
import re
script,from_file= argv

for line in open(from_file):
    ori_file = line.rstrip('\n') 
    with io.open(ori_file, encoding='utf-8') as f:
        fw=open('eng_tourism_temp.txt','a')
        for line in f:
            t=line.split(':')
            n=len(t)
            for i in t[n-1].lstrip():
                fw.write(i.encode('utf-8'))
            
