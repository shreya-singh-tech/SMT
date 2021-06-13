#install nltk
sudo apt-get install python-pip python-dev build-essential 
sudo pip install --upgrade pip
sudo pip install nltk
#to download nltk_data:
python 
import nltk
nltk.download('all')

#php for wikipedia parsing
sudo apt-get install build-essential libxml2-dev
wget http://in1.php.net/distributions/php-5.3.29.tar.bz2
tar -xvf php-5.3.29.tar.bz2
cd php-5.3.29
./configure
make
sudo make install

