from sys import argv
import io
import nltk
from nltk.tokenize import sent_tokenize,word_tokenize
from nltk.corpus import stopwords
from nltk.stem import PorterStemmer
from nltk.stem import WordNetLemmatizer
from nltk.tree import *
from nltk.util import *
import re
script , from_file  = argv

i=0
temp=[]
k=0
a=2

lemmatizer = WordNetLemmatizer()
stemmer = PorterStemmer()
stopwords =stopwords.words('english')

with io.open( from_file, "r", encoding='utf-8') as f:
    indata = f.read()
temp=indata.splitlines()

while a < len(temp):
    tree=Tree.fromstring((temp[a]).encode('utf-8'))
   
    for s in tree.subtrees():
      	if type(s) is nltk.Tree:
	    if (s.label() == 'S'):
                for x in s:
                    if type(x) is nltk.Tree and (x.label() == 'NP' or x.label()=='VP' or x.label()=='ADJP') :
                            for i in x.leaves():
				print i.lower(),
                            print('\n')
			
		    else:
                      	for y in x:
			    if type(y) is nltk.Tree and (y.label() == 'NP' or y.label()=='VP' or y.label()=='ADJP') :
                        	    for i in y.leaves():
					print i.lower(),
 		    	            print('\n')
    for subtree in tree.subtrees(filter = lambda t: t.label()=='NP' and (t.height()==3 or t.height()==4)):
            for i in subtree.leaves():
		print i.lower(),
	    print('\n')	
	   
    
    a=a+2

