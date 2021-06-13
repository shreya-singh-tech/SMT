from __future__ import division
import os
from collections import Counter
import glob
from sys import argv
import io
from nltk.corpus import stopwords
import re


stop_words=set(stopwords.words('english'))

script,list_file=argv

def total_word_count(fileobj, stop_word):
    file_words = (word.lower() for line in fileobj for word in line.split())
    filtered_words = (word for word in file_words if word in stop_word)
    c2=sum(Counter(file_words).values())
    return c2

def word_count(fileobj, words):
    file_words = (word.lower() for line in fileobj for word in line.split())
    filtered_words = (word for word in file_words if word in words)
    c= sum(Counter(filtered_words).values())
    return c    
   
def ratio(dirpath, words, action=None):
    """For each .txt file in a dir, count the specified words"""
    for filepath in glob.iglob(os.path.join(dirpath, '*.txt')):
        with open(filepath) as f:
	    c2 = total_word_count(f, stop_words)
        f.close()
	with open(filepath) as f:
            ct = word_count(f,words)
	f.close()
        ratio=ct/c2
	print ratio
	if ratio < 0.22:
	    if action:
                action(filepath, ratio)


def print_summary(filepath, ct):
    os.remove(filepath)

words=set()
for line in open(list_file) :
    if line.strip() not in stop_words and line.strip()!=".":
	 words.add(line.strip())
ratio('./', words, action=print_summary)
