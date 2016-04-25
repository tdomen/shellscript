#!/bin/sh
# mac用texインストールスクリプト
# 動くかどうか未検証
# このスクリプトを実行したあとにターミナルで「source .bashrc」

cd ~/Downloads
curl -O http://www2.kumagaku.ac.jp/teacher/herogw/archive/UTeX20151009.dmg
mount_dir=`hdiutil attach UTeX20151009.dmg | awk -F '\t' 'END{print $NF}'`
sudo ditto "$mount_dir/UpTeX.app" "/Applications/UpTeX.app"
hdiutil detach "$mount_dir"
rm "UTeX20151009.dmg"

SHRC='.bashrc'

cd ~
cat <<'EOT'>> $SHRC

export PATH="$PATH:/Applications/UpTeX.app/Contents/Resources/TEX/texbin"

function tex(){
test -n "$1" || echo "usage: platex2pdf [tex-file]"
test -n "$1" || exit 1 # 引数が無ければ syntax を表示して終了
TEX=$*
DVI=`/usr/bin/basename "$TEX" ".tex"`
PDF="${DVI}.pdf"
THECODE=`nkf -g "$TEX"`
case "$THECODE" in # nkf が返す文字コードにあわせる
    "UTF-8") 
	KANJI="-kanji=utf8"
	OPTION="-w";;
    "EUC-JP") 
	KANJI="-kanji=euc"
	OPTION="-e";;
    "Shift_JIS") 
	KANJI="-kanji=sjis"
	OPTION="-s";;
    "ISO-2022-JP") 
	KANJI="-kanji=jis"
	OPTION="-j";;
esac
# 各種ファイルを変換
ls | grep "\.sty" >/dev/null 2>&1
if test $? -eq 0 ;then
    for STYFILE in *.sty
    do
	nkf $OPTION --overwrite $STYFILE
    done
fi
ls | grep "\.bib" >/dev/null 2>&1
if test $? -eq 0 ;then
    for BIBFILE in *.bib
    do
	nkf $OPTION --overwrite $BIBFILE
    done
fi
ls | grep "\.bst" >/dev/null 2>&1
if test $? -eq 0 ;then
    for BSTFILE in *.bst
    do
	nkf $OPTION --overwrite $BSTFILE
    done
fi

PLATEX="platex"
BIBTEX="pbibtex"
CLASS=`sed -n '/documentclass/p' $* | sed '/%.*documentclass/d' | sed -n '1p'`
case $CLASS in
    *{u*) PLATEX="uplatex";;
esac
$PLATEX $KANJI $TEX # platex コマンドの発行
$BIBTEX $DVI # >/dev/null 2>&1 # pbibtex コマンドの発行
$PLATEX $KANJI $TEX >/dev/null 2>&1 # platex コマンドの発行
$PLATEX $KANJI $TEX >/dev/null 2>&1 # platex コマンドの発行
dvipdfmx $DVI # dvipdfmx コマンドの発行
open $PDF & # PDFファイルを表示
rm *.aux *.log *.dvi *.bbl *.blg
}
EOT
