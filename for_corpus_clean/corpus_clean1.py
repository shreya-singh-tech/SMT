#for cleaning corpus with <a>or<s>

import codecs
from sys import argv
import io
import re
script,from_file,to_file= argv


with codecs.open(from_file, encoding='utf-8') as f:
   fw=open(to_file,'w')
   for line in f:
      t=line.split('>')
      for i in t[1].lstrip():
            fw.write(i.encode('utf-8'))
            
    
