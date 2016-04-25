#!/bin/sh

if [ $# != 1 ]; then
    exit 0
fi

URL=$1
LF=$'\\\x0A'

SOURCE=`curl $URL`
IMG_URLs=`echo "$SOURCE" | sed -n '/<p>/,/<\/p>/p' | grep ".jpg"  | sed 's/<\/a><br \/>//g' | sed "s/<\/a><br \/>/$LF/g"`
TITLE=`date +%Y%m%d%H%M`
IMG_URL=`echo -e "$IMG_URLs" | sed -e 's/[^"]*"\([^"]*\)".*/\1/'`
echo "$IMG_URL" > ./temp.txt
echo "$TITLE"
mkdir ~/Pictures/".$TITLE"

cnt=0
while read line
do
    echo "$line"
    cnt=`expr $cnt + 1`
    wget "$line" -O ~/Pictures/".$TITLE"/"$cnt.jpg"
done < ./temp.txt
rm temp.txt
