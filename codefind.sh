#!/bin/zsh

local -A opthash
zparseopts -D -M -A opthash -- \
    s \
    h -help=h

usage() {
  echo "Usage: $PROGNAME <option> [argument1] (argument2)"
  echo 
  echo "オプション:"
  echo "  -h, --help"
  echo "  -s  [argument1] [argument2] argument1を検索後，argument2の文字列に置換"
  echo
  exit 1
}

if [[ -n "${opthash[(i)-h]}" ]]; then
    # -hまたは--helpが指定された場合
    usage
    exit 1
elif [[ -n "${opthash[(i)-s]}" ]]; then
    # -sが指定された場合
    if [ $# != 2 ]; then
	exit 0
    fi
    STRING=$1
    RESTRING=$2

    COUNT=`sudo find . -type f -name "*.txt" -or -name "*.nc" -or -name "*.java" -or -name "*.c" -or -name "*.h" -or -name "*.py" -or -name "*.rb" -or -name "*.sh" -or -name "*.tex" -or -name "*.sty" -or -name "*.bib" -or -name "Make*" | xargs grep -ls $STRING --color | wc -l`

    sudo find . -type f -name "*.txt" -or -name "*.nc" -or -name "*.java" -or -name "*.c" -or -name "*.h" -or -name "*.py" -or -name "*.rb" -or -name "*.sh" -or -name "*.tex" -or -name "*.sty" -or -name "*.bib" -or -name "Make*" | xargs grep -ns $STRING --color
 
    if [ $COUNT -ne 0 ]; then
	while true; do
	    echo -n "Replace?[y/n]---->"; read ans
	    case $ans in
		y)
		    for file in `sudo find . -type f -name "*.txt" -or -name "*.nc" -or -name "*.java" -or -name "*.c" -or -name "*.h" -or -name "*.py" -or -name "*.rb" -or -name "*.sh" -or -name "*.tex" -or -name "*.sty" -or -name "*.bib" -or -name "Make*" | xargs grep -ls $STRING`
		    do
			echo $file
			sudo sed -i -e "s|$STRING|$RESTRING|g" $file >/dev/null 2>&1
		    done
		    break
		    ;;
		n)
		    echo ""
		    break
		    ;;
		*)
		    echo -e "Please y or n\n"
		    ;;
	    esac
	done
    fi
else
    # オプションなし
    if [ $# != 1 ]; then
	exit 0
    fi
    
    STRING=$1

    sudo find . -type f -name "*.txt" -or -name "*.nc" -or -name "*.java" -or -name "*.c" -or -name "*.h" -or -name "*.py" -or -name "*.rb" -or -name "*.sh" -or -name "*.tex" -or -name "*.sty" -or -name "*.bib" -or -name "Make*" | xargs grep -ns $STRING --color
fi

# sudo grep -rn "" ./ | grep $STRING --color
# grep "*.txt\|*.nc\|*.java *.py\|*.rb\|*.c\|*.sh\|*.tex\|*.sty\|*.bib"
