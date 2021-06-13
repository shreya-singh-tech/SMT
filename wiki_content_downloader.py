import wikipedia
from sys import argv
import io
import os.path
from bs4 import BeautifulSoup 
import requests 

script,from_file=argv
save_path = '/home/iitp/wiki-scrapper/eng_h'

with io.open(from_file,"r",encoding='utf-8') as f:
    indata=f.read()

temp=indata.splitlines()

seen=[]
for title in temp:
    if title not in seen:
	seen+=title
        try:
	    ENGLISH_PAGE_TITLE = title
	    completeName = os.path.join(save_path,ENGLISH_PAGE_TITLE)
    	    with open(completeName+ "_en_wiki_article.txt", 'w+') as file:
                p = wikipedia.page(ENGLISH_PAGE_TITLE)
                for i in p.content:
                    file.write(i.encode('utf-8'))

  
        except wikipedia.exceptions.DisambiguationError as e:
            try:
		topics = e.options
                for i in topics:
		    completeName = os.path.join(save_path,i)
		    with open(completeName + "_en_wiki_article.txt", 'w+') as file:
                        p = wikipedia.page(i)
		        for x in p.content:
                            file.write(x.encode('utf-8'))
	    except wikipedia.exceptions.DisambiguationError:
		continue
	    except wikipedia.exceptions.PageError:
	        continue
	    except requests.exceptions.SSLError:
	        continue
               
        except wikipedia.exceptions.PageError:
	    continue
	except requests.exceptions.SSLError:
	    continue
    else:
	continue
#regex for removing headings (=){2,} [^\n]* (=){2,}
