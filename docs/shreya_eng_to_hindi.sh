##Start corpus preparation

cd ~/corpora/parallel

#tokenise

~/mosesdecoder/scripts/tokenizer/tokenizer.perl -l en <~/corpora/parallel/training.en.txt >~/corpora/parallel/training.en.tok.txt
cd ~/
git clone https://github.com/anoopkunchukuttan/indic_nlp_library.git

#unzip ~/indic_nlp_library-master.zip
cd ~/indic_nlp_library/src/indicnlp/tokenize
python indic_tokenize.py ~/corpora/parallel/training.hi.txt ~/corpora/parallel/training.hi.tok.txt hi

#truecase data

~/mosesdecoder/scripts/recaser/train-truecaser.perl --model ~/corpora/parallel/training.en.pretrue.txt --corpus ~/corpora/parallel/training.en.tok.txt

~/mosesdecoder/scripts/recaser/truecase.perl --model ~/corpora/parallel/training.en.pretrue.txt <~/corpora/parallel/training.en.tok.txt >~/corpora/parallel/training.en.true.txt

#clean resulting data

cd ~/corpora/parallel/
cp  training.hi.tok.txt training.hi.true.txt



~/mosesdecoder/scripts/training/clean-corpus-n.perl ~/corpora/parallel/training.en.true txt txt ~/corpora/parallel/corpora_train.clean.en.txt 1 80

~/mosesdecoder/scripts/training/clean-corpus-n.perl ~/corpora/parallel/training.hi.true txt txt ~/corpora/parallel/corpora_train.clean.hi.txt 1 80


##Language Model Training via irstlm

cd ~/corpora/parallel
mkdir lm
cd lm
~/irstlm/bin/add-start-end.sh <~/corpora/parallel/monolingual.hi.txt >lm_train.lm.sh.hi

export IRSTLM=~/smt/irstlm
LD_LIBRARY_PATH=/home/iit/irstlm/lib
export LD_LIBRARY_PATH

#prepare 3 gram language model
~/irstlm/bin/build-lm.sh -i ~/corpora/parallel/lm/lm_train.lm.sh.hi -t ./temp -p -s improved-kneser-ney -n 3 -o ~/corpora/parallel/lm/corpora_train.lm.final.hi.txt

~/irstlm/bin/compile-lm --text=yes corpora_train.lm.final.hi.txt.gz corpora_train.lm.final.arpa.hi

#convert language model file to binary format
~/mosesdecoder/bin/build_binary corpora_train.lm.final.arpa.hi corpora_train.lm.arpa.binary


##Training the Translation System

cd ~/corpora/parallel
mkdir working
cd working

#run wordalignment (using GIZA++), phrase extraction and #scoring, create lexicalised reordering tables and create 
#Moses configuration file

~/mosesdecoder/scripts/training/train-model.perl -root-dir train -corpus ~/corpora/parallel/corpora_train.clean.en.txt -f txt -e txt -alignment grow-diag-final-and -reordering msd-bidirectional-fe -lm 0:3:$HOME/corpora/parallel/lm/corpora_train.lm.arpa.binary:1 -external-bin-dir ~/bin | tee training.out


#Tuning

cd ~/corpora/parallel
~/mosesdecoder/scripts/tokenizer/tokenizer.perl -l en <~/corpora/parallel/tune/dev.en.txt >~/corpora/parallel/tune/corpora_tune.tok.en

cd ~/indic_nlp_library/src/indicnlp/tokenize
python indic_tokenize.py ~/corpora/parallel/tune/dev.hi.txt ~/corpora/parallel/tune/corpora_tune.tok.hi hi



~/mosesdecoder/scripts/recaser/truecase.perl --model ~/corpora/parallel/training.en.pretune.txt <~/corpora/parallel/tune/corpora_tune.tok.en >~/corpora/parallel/tune/corpora_tune.true.en

cd ~
cd corpora/parallel/tune
cp corpora_tune.tok.hi corpora_tune.true.hi

~/mosesdecoder/scripts/training/clean-corpus-n.perl ~/corpora/parallel/tune/corpora_tune.true en hi ~/corpora/parallel/tune/corpora_tune.clean 1 80


cd ~/corpora/parallel/

nohup nice ~/mosesdecoder/scripts/training/mert-moses.pl ~/corpora/parallel/tune/corpora_tune.en ~/corpora/parallel/tune/corpora_tune.hi ~/mosesdecoder/bin/moses ~/corpora/parallel/working/train/model/moses.ini --working-dir ~/corpora/parallel/tune/ mertdir ~/mosesdecoder/bin/ | tee mert.out


~/mosesdecoder/scripts/training/mert-moses.pl tune/training.en.txt tune/training.hi.txt ~/mosesdecoder/bin/moses working/train/model/moses.ini --mertdir ~/mosesdecoder/bin



cd ~/set_eng_to_hindi/test/

~/mosesdecoder/scripts/tokenizer/tokenizer.perl -l en <~/set_eng_to_hindi/test/test.en.text >~/set_eng_to_hindi/test/test.tok.en


~/smt/mosesdecoder/scripts/recaser/truecase.perl --model ~/set_eng_to_hindi/corpora_train.pretrue.en <~/set_eng_to_hindi/test/test.tok.en >~/set_eng_to_hindi/test/test.true.en

#~/smt/mosesdecoder/bin/moses -f ~/set_eng_to_hindi/tune/mert-work/moses.ini <test.true.en >test.out.hi.text

~/smt/mosesdecoder/bin/moses -f ~/set_eng_to_hindi/mert-work/moses.ini <test.true.en >test.out.hi.text


#This portion is used for bleu score (Optional)
cd ~
cd smt/indic_nlp_library/src/indicnlp/tokenize

python indic_tokenize.py ~/set_eng_to_hindi/test/test.hi.text ~/set_eng_to_hindi/test/test.tok.hi hi

~/smt/mosesdecoder/scripts/generic/multi-bleu.perl -lc ~/set_eng_to_hindi/test/test.tok.hi <~/set_eng_to_hindi/test/test.out.hi.text | tee ~/set_eng_to_hindi/test/blue_score
