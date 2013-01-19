#!/bin/bash
m=0;
for i in $(cat list);
do
        ofile=$(printf "%03d" $m)
        echo $i | perl -n -e '$n=1; chomp; for $i (split(//)) {print "$i "; if(($n++)%9 == 0) {print "\n"}}' > sudoku.hard.$ofile
        m=$(($m + 1))
done
