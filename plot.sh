#!/bin/sh
#
#引数：取り込むファイル名，出力ファイル名（拡張子なし）
#gnuplotでプロットし，EPSファイルで保存する

#--- 引数チェック、格納。使用方法表示。
### $#はコマンドラインに続く文字列の数。
if [ $# != 2 ]; then
    exit 0
fi

### 引数は、図のタイトル、xの最小値、xの最大値の３つ。
INPUT=$1
OUTPUT="$2.eps"

#---シェル内でのgnuplot起動
#### EOF行までの間に空行を挟んではいけない。
gnuplot <<EOF
set terminal postscript eps
set output "$OUTPUT"
unset key
unset x2zeroaxis
unset y2zeroaxis
set tics font "Times-Roman,20"
set tics in
set xr[0:1000]
set yr[480:540]
set xtics 200
set ytics 20
#set xlabel "Time [ms]" font "Times-Roman,24"
#set ylabel "Illuminance [lx]" font "Times-Roman,24"
set datafile separator ','
# plot "$INPUT" u 1:2 with lines lw 3
# set boxwidth 0.5 relative
plot "$INPUT" u 1:2 with boxes lw 3
EOF


mv $OUTPUT /home/tdomen/ipsj-unix/img
evince /home/tdomen/ipsj-unix/img/$OUTPUT
