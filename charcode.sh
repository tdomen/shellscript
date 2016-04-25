#!/bin/zsh

# これはzshでしか動かない
# bashとかだと違うオプション解析使うみたい

local -A opthash
zparseopts -D -M -A opthash -- \
    w \
    s \
    e \
    h -help=h 

usage() {
  echo "Usage: $PROGNAME <option>"
  echo 
  echo "オプション:"
  echo "  -h, --help"
  echo "  -w         カレントディレクトリ内のすべてのファイルをUTF-8に変換"
  echo "  -s         カレントディレクトリ内のすべてのファイルをShift-JISに変換"
  echo "  -e         カレントディレクトリ内のすべてのファイルをEUC-JPに変換"
  echo
  exit 1
}

if [[ -n "${opthash[(i)-h]}" ]]; then
    # -hまたは--helpが指定された場合
    usage
    exit 1
elif [[ -n "${opthash[(i)-w]}" ]]; then
    # -wが指定された場合
    for file in `find . -maxdepth 1 -type f`
    do
	nkf -w --overwrite $file
    done
    exit 1
elif [[ -n "${opthash[(i)-s]}" ]]; then
    # -sが指定された場合
    for file in  `find . -maxdepth 1 -type f`
    do
	nkf -s --overwrite $file
    done
    exit 1
elif [[ -n "${opthash[(i)-e]}" ]]; then
    # -eが指定された場合
    for file in  `find . -maxdepth 1 -type f`
    do
	nkf -e --overwrite $file
    done
    exit 1
else
    # オプションなし
    nkf -g *
fi
