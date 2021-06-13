sudo apt-get install g++
sudo apt-get install git
sudo apt-get install subversion
sudo apt-get install automake
sudo apt-get install libtool
sudo apt-get install zlib1g-dev
sudo apt-get install libboost-all-dev
sudo apt-get install libbz2-dev
sudo apt-get install liblzma-dev
sudo apt-get install python-dev
sudo apt-get install graphviz
sudo apt-get install imagemagick
sudo apt-get install make
sudo apt-get install cmake
sudo apt-get install libgoogle-perftools-dev
sudo apt-get install build-essential

cd ~
mkdir smt
cd smt

#download giza++
git clone https://github.com/moses-smt/giza-pp.git

cd ~
#download irstlm 5.80.08
wget http://sourceforge.net/projects/irstlm/files/irstlm/irstlm-5.80/irstlm-5.80.08.zip/download

#unzip irstlm

#download boost
wget http://downloads.sourceforge.net/project/boost/boost/1.55.0/boost_1_55_0.tar.gz


tar zxvf boost_1_55_0.tar.gz
cd boost_1_55_0

./bootstrap.sh
#boost install
./b2 -j4 --prefix=$PWD --libdir=$PWD/lib64 --layout=system link=static install || echo FAILURE

#install giza++
cd ~/smt/giza-pp
make

cd ~/smt
mkdir bin
cp ~/smt/giza-pp/GIZA++-v2/GIZA++ ~/smt/giza-pp/mkcls-v2/mkcls ~/smt/giza-pp/GIZA++-v2/plain2snt.out ~/smt/giza-pp/GIZA++-v2/snt2plain.out ~/smt/giza-pp/GIZA++-v2/snt2cooc.out bin

#install irstlm
cd ~/irstlm-5.80.08/trunk
./regenerate-makefiles.sh
sudo apt-get update
sudo apt-get install autoconf
./configure --prefix=/home/iitp/irstlm
cmake 
make
make install
cd ~/
LD_LIBRARY_PATH=~/irstlm/lib
export LD_LIBRARY_PATH
#exit

#download moses
cd ~
git clone https://github.com/moses-smt/mosesdecoder.git
cd ~/mosesdecoder/
#moses install
#cd ~/boost_1_55_0

#./bjam -j4
./bjam --with-boost=/home/iitp/boost_1_55_0 --with-irstlm=/home/iitp/irstlm --with-giza-pp=/home/iitp/smt/bin -j4

