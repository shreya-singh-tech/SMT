cd ~/lang-models/news
cd ~/indic_nlp_library/src/indicnlp/tokenize
python indic_tokenize.py ~/lang-models/news/hi_news.txt ~/lang-models/news/news.hi.tok.txt hi
~/srilm/bin/i686/ngram-count -order 3 -interpolate -kndiscount -unk -text ~/lang-models/news/news.hi.tok.txt -lm ~/lang-models/news/news.hi.lm
cd ~/lang-models/news
 ~/mosesdecoder/bin/build_binary news.hi.lm news.hi.lm.binary
cd ~/lang-models/social
cd ~/indic_nlp_library/src/indicnlp/tokenize
python indic_tokenize.py ~/lang-models/social/social.hi.txt ~/lang-models/social/social.hi.tok.txt hi
~/srilm/bin/i686/ngram-count -order 3 -interpolate -kndiscount -unk -text ~/lang-models/social/social.hi.tok.txt -lm ~/lang-models/social/social.hi.lm
cd ~/lang-models/social
 ~/mosesdecoder/bin/build_binary social.hi.lm social.hi.lm.binary
cd ~/lang-models/tech
cd ~/indic_nlp_library/src/indicnlp/tokenize
python indic_tokenize.py ~/lang-models/tech/tech.hi.txt ~/lang-models/tech/tech.hi.tok.txt hi
~/srilm/bin/i686/ngram-count -order 3 -interpolate -kndiscount -unk -text ~/lang-models/tech/tech.hi.tok.txt -lm ~/lang-models/tech/tech.hi.lm
cd ~/lang-models/tech
 ~/mosesdecoder/bin/build_binary tech.hi.lm tech.hi.lm.binary
cd ~/lang-models/tourism
cd ~/indic_nlp_library/src/indicnlp/tokenize
python indic_tokenize.py ~/lang-models/tourism/hindi_tourism.txt ~/lang-models/tourism/tour.hi.tok.txt hi
~/srilm/bin/i686/ngram-count -order 3 -interpolate -kndiscount -unk -text ~/lang-models/tourism/tour.hi.tok.txt -lm ~/lang-models/tourism/tour.hi.lm
cd ~/lang-models/tourism
 ~/mosesdecoder/bin/build_binary tour.hi.lm tour.hi.lm.binary
