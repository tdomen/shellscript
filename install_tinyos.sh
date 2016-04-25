#!/bin/sh

# これを動かせば勝手にTinyOSが入ってくれるはず
# zsh使いたかったら適当に書き換えてください
# ubuntu推薦．スクリプト回した後にsourceしてください

sudo su
echo "deb http://tinyos.stanford.edu/tinyos/dists/ubuntu lucid main" >> /etc/apt/sources.list
echo "deb http://tinyos.stanford.edu/tinyos/dists/ubuntu maverick main" >> /etc/apt/sources.list
echo "deb http://tinyos.stanford.edu/tinyos/dists/ubuntu natty main" >> etc/apt/sources.list

apt-get update
apt-get install tinyos-2.1.2
apt-get install subversion
svn checkout http://tinyos-main.googlecode.com/svn/trunk/ tinyos-main-read-only
cp -R /opt/tinyos-main-read-only /opt/tinyos-2.x

cd /opt/tinyos-2.1.2
echo "#! /usr/bin/env bash\n# Here we setup the environment\n# variables needed by the tinyos\n# make system\necho \"Setting up for TinyOS 2.1.2 Repository Version\"\nexport TOSROOT=\nexport TOSDIR=\nexport MAKERULES=\nTOSROOT=\"/opt/tinyos-2.1.2\"\nTOSDIR=\"$TOSROOT/tos\"\nCLASSPATH=$CLASSPATH:$TOSROOT/support/sdk/java:.:$TOSROOT/support/sdk/java/tinyos.jar\nMAKERULES=\"$TOSROOT/support/make/Makerules\"\nPYTHONPATH=\".:$TOSROOT/support/sdk/python:$PYTHONPATH\"\nexport TOSROOT\nexport TOSDIR\nexport CLASSPATH\nexport MAKERULES\nexport PYTHONPATH" >> tinyos.sh

cd /opt/tinyos-2.x
echo "#! /usr/bin/env bash\n# Here we setup the environment\n# variables needed by the tinyos\n# make system\necho \"Setting up for TinyOS 2.x Repository Version\"\nexport TOSROOT=\nexport TOSDIR=\nexport MAKERULES=\nTOSROOT=\"/opt/tinyos-2.1.2\"\nTOSDIR=\"$TOSROOT/tos\"\nCLASSPATH=$CLASSPATH:$TOSROOT/support/sdk/java:.:$TOSROOT/support/sdk/java/tinyos.jar\nMAKERULES=\"$TOSROOT/support/make/Makerules\"\nexport TOSROOT\nexport TOSDIR\nexport CLASSPATH\nexport MAKERULES" >> tinyos.sh

cp /opt/tinyos-2.1.2/tinyos.sh /opt/tinyos-2.x/tinyos.sh
chmod +x /opt/tinyos-2.x/tinyos.sh

cd ~
echo "source /opt/tinyos-2.1.2/tinyos.sh\nexport CLASSPATH=$CLASSPATH:.\nexport MOTECOM=serial@/dev/ttyUSB1:57600\n\nfunction micaz_install(){make micaz install,$1 mib520,/dev/ttyUSB0}" >> .bashrc

