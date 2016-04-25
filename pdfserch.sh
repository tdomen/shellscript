#!/bin/zsh

# pdftotextコマンドのインストールが必須
# zshでしか動きません

local -A opthash
zparseopts -D -M -A opthash -- \
    d \
    h -help=h

DIRECTORY_PATH="/home/tdomen/Research/参考文献" # 普段pdfを格納している場所

usage() {
  echo "Usage: $PROGNAME <option> ([DIRECTORY_PATH]) [argument]"
  echo 
  echo "オプション:"
  echo "  -h, --help"
  echo "  -d  [DIRECTORY_PATH] ディレクトリを指定"
  echo
  exit 1
}

if [[ -n "${opthash[(i)-h]}" ]]; then
    # -hまたは--helpが指定された場合
    usage
    exit 1
elif [[ -n "${opthash[(i)-d]}" ]]; then
    # -dが指定された場合
    if [ $# != 2 ]; then
	exit 0
    fi
    DIRECTORY_PATH="$1"
    STRING="$2"
else
    # オプションなし
    if [ $# != 1 ]; then
	exit 0
    fi
    STRING="$1"
fi

PRE_IFS=$IFS
IFS=$'\n'

mkdir $DIRECTORY_PATH/temp/
ls $DIRECTORY_PATH | grep pdf > $DIRECTORY_PATH/temp/temp.txt

while read line
do
    if [ -e $DIRECTORY_PATH/"$line" ];then
	textname=`basename "$line" ".pdf"`
	textname="${textname}.txt"
	pdftotext -raw $DIRECTORY_PATH/"$line" $DIRECTORY_PATH/temp/"$textname" | sed ':loop; N; $!b loop; ;s/\n//g' >/dev/null 2>&1
	grep -l $STRING $DIRECTORY_PATH/temp/"$textname" --color | sed 's|/temp||g' | sed 's|.txt|.pdf|g' #>/dev/null 2>&1
    fi
done < $DIRECTORY_PATH/temp/temp.txt

cd $DIRECTORY_PATH
rm -rf temp
IFS=$PRE_IFS
