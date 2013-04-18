out=`echo $1 | sed s/[^\.]*$//`bed

echo 'track name="DNMT3" description="couting unique hits" visibility=2 graphType=bar' > $out

awk '{printf("%s\t%d\t%d\t%d\n",$1,$2,$2+1,$3)}' $1 >> $out
