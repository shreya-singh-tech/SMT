import webhose
import os
import time
import datetime
import sys
import codecs
from sys import argv
import io

base_dir="corpus/"
script,from_file=argv

with io.open(from_file,"r",encoding='utf-8') as f:
    indata=f.read()

temp=indata.splitlines()

seen=[]
for title in temp:
    if title not in seen:
	seen+=title
	try:
	    topic=title.encode('utf-8')
	    webhose.config(token="285f8a4c-fad5-4de3-90df-5869ff50a625")
	    query=webhose.Query()
	    query.language="english"
	    query.title=topic.encode('utf-8')
	 
	    query.exclude=("watch")
	    query.site_type="news"
	    response=webhose.search(query)
	    post_dict={}
	    for post in response.posts:
		post_tuple=(post.title,post.thread.site_full,post.text)
		post_date=post.published[0:10]
		if(post_dict.has_key(post_date)):
			post_dict[post_date].append(post_tuple)
		else:
			post_dict[post_date]=[post_tuple]

            if not os.path.exists(base_dir+topic):
		os.makedirs(base_dir+topic)

	    for date in post_dict.keys():
		if not os.path.exists(base_dir+topic+"/"+date):
			os.makedirs(base_dir+topic+"/"+date)
		for article in post_dict[date]:
			with codecs.open(base_dir+topic.encode('utf-8')+"/"+date+"/"+article[0].replace("/","|")+"__"+article[1]+".txt","w+",encoding="utf-8",errors="ignore") as file:
				file.write(article[2])
        except IOError:
	    continue	
