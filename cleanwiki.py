#to clean<>
import re
import io
from sys import argv
script,file_name=argv
with io.open(file_name,'r',encoding='utf-8') as f:
    for line in f:
	try:
	    print(re.sub('<[^>]+>', '', line)),
        except UnicodeEncodeError:
	    continue



