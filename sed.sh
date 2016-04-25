#!bin/sh

mkdir backup

for FILE in *.c
do
    cp $FILE ./backup
    nkf -w -Lu --overwrite $FILE
    sed -i -e "s/<stdio.h>/<stdlib.h>/g" $FILE
    OIFS="$IFS"; IFS='_'
    set -- $FILE; IFS="$OIFS"
    echo "$2"
    mkdir -p $2
    mv $FILE $2
done
