#!/bin/bash

tmpdir=/tmp
cescpath=/opt/cryptoescudo
cescdatapath=$cescpath/data
cescdaemonscript=$cescpath/cesc_daemon.sh
cescdebugscript=$cescpath/cesc_debug.sh
cescqueryscript=$cescpath/cesc_query.sh
cescconffile=$cescdatapath/cryptoescudo.conf

# Create folders
[ ! -d "$tmpdir" ] && mkdir -p "$tempdir"
mkdir $cescpath
mkdir $cescdatapath

cd $tempdir

# Apt update
apt-get update -y

# Generic Utils
apt-get install curl wget zip unzip nano apt-utils -y

# Build utils
apt-get install build-essential -y

# Fix Bignum error
apt-get install libssl-dev -y
apt-get install libssl1.0-dev -y

apt-get install libdb4.8-dev -y
apt-get install libdb4.8++-dev -y
apt-get install libboost-all-dev -y

# Fix missing file "db_cxx.h"
apt-get install libdb++-dev -y

# Fix fatal error: miniupnpc/miniwget.h
apt-get remove qt3-dev-tools libqt3-mt-dev -y
apt-get install libqt4-dev libminiupnpc-dev -y

# Fix /usr/bin/ld: cannot find -lz
apt-get install zlib1g-dev -y

cd $tmpdir
rm v1.1.5.1-20141117-public.zip
rm -Rf v1.1.5.1-20141117-public

# Download source
wget -O v1.1.5.1-20141117-public.zip http://cryptoescudo.pt/download/20141117/source.zip

# Unzip source
unzip v1.1.5.1-20141117-public.zip
mv source v1.1.5.1-20141117-public
cd v1.1.5.1-20141117-public/src/

# Update atomic_pointer.h with ARM64 support
wget -O leveldb/port/atomic_pointer.h https://raw.githubusercontent.com/VDamas/cryptoescudo/master/src/leveldb/port/atomic_pointer.h
chmod +x leveldb/build_detect_platform

make -f makefile.unix

cp cryptoescudod $cescpath/cryptoescudod
chmod +x $cescpath/cryptoescudod

# Create cryptoescudo daemon script
tee "$cescdaemonscript" > /dev/null <<EOF
$cescpath/cryptoescudod -datadir=$cescdatapath -daemon
EOF
chmod +x $cescdaemonscript

# Create cryptoescudo debug script
tee "$cescdebugscript" > /dev/null <<EOF
tail -f $cescdatapath/debug.log

EOF
chmod +x $cescdebugscript

# Create cryptoescudo query script
tee "$cescqueryscript" > /dev/null <<EOF
$cescpath/cryptoescudod -datadir=$cescdatapath \$1 \$2 \$3
EOF
chmod +x $cescqueryscript

# Create cryptoescudo.conf
rpcpass=$(openssl rand -hex 32) # generate pass
tee "$cescconffile" > /dev/null <<EOF
rpcuser=cryptoescudorpc
rpcpassword=$rpcpass
rpcport=61142
rpcallowip=127.0.0.1
server=1
listen=1
txindex=1
EOF

if [[ $1 == true ]]; then
# Download chain - dropbox
#wget -O chain.zip https://uc3a006a0273e299b2c55b2d9bb7.dl.dropboxusercontent.com/cd/0/get/AkoyaRMW_nPcFiX5VLQZt3Nn59RxY__YzGyZYhlof5x4FfvqNDxZYnnOjYR4ZyZ5dnCpn6nuK2k1nKlg$# Unzip chain
#unzip chain.zip
#mv Cryptoescudo/* $cescdatapath

# Download chain - Drive - Feb/2021 
wget -O /usr/sbin/gdrivedl 'https://f.mjh.nz/gdrivedl'
chmod +x /usr/sbin/gdrivedl
gdrivedl 14uHoEQNa510UF_2SNFFcwAELqUJo8nPn ./chain.zip
# Unzip chain
unzip chain.zip -d $cescdatapath
fi

chmod +x $cescdaemonscript
chmod +x $cescdebugscript

