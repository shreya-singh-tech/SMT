#for removing _32653 from corpus

from sys import argv
import io
import re
script,from_file= argv


with io.open(from_file, encoding='utf-8') as f:
    fw=open('english_toursim.txt','a')
    for line in f:
        t=line.split('_')
        fw.write(t[0].encode('utf-8')+' ')
        for w in t:
	    a=w.split('  ')
	    i=1
	    while i< len(a):
		fw.write((a[i].lstrip()).encode('utf-8')+' ')	  
	        i=i+1
        fw.write('.'+'\n') 	
   	   

	  
      
