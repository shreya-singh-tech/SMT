from sys import argv
import os
import io
script, from_file=argv
a=0
seen=set()

with io.open( from_file, "r", encoding='utf-8') as f:
    indata = f.read()
    temp=indata.splitlines()
#threshold used is 6 as that length of phrases are found to be most repetetive
while a < len(temp):
    if temp[a] not in seen:
	    seen.add(temp[a])
            wordslist=temp[a].split()
            words=len(wordslist)
            if words<=6 :
	         print(temp[a].encode('utf-8'))  
				
    a=a+2

