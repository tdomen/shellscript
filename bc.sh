#!/bin/sh

i=6
j=6
k=1

x=`echo "1.5" | bc`
y=`echo "1.5" | bc`

x_condition=0
y_condition=0
first_condition=0
second_condition=0
while :
do
    x=`echo "1.5" | bc`
    while :
    do
	x=`echo "$x+0.1" | bc`
	x_condition=`echo "$i*3.0+0.6-1.5" | bc`
	first_condition=`echo "$x==$x_condition" | bc`
	if test $first_condition -eq 1 ;then
	    break
	fi
    done
    y=`echo "$y+0.1" | bc`
    y_condition=`echo "$j*3.0+0.6-1.5" | bc`
    second_condition=`echo "$y==$y_condition" | bc`
    if test $second_condition -eq 1 ;then
	break
    fi
done
