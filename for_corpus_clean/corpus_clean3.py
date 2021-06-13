#for cleaning corpus with #in hindi

import codecs
from sys import argv
import io
import re
script,from_file= argv
for line in open(from_file):
    ori_file = line.rstrip('\n')
    with codecs.open(ori_file, encoding='utf-8') as f:
        fw=open('hindi_health.txt','a')
        for line in f:
            if line[0]=='c':
	        continue
            t=line.split(' ')
            for w in t:
	        a=w.split('#')
	        for i in a[0].lstrip():
                    if i==':':
			continue
		    elif u'\0030'<= i <= u'\0039':
			continue
		    else:
			fw.write(i.encode('utf-8'))
                fw.write(' ')
	    fw.write('.\n')
	   
