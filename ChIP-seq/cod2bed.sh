awk 'BEGIN{OFS="\t"}{ temp=substr($1,NR==1?2:1); $1=(NR==1?"#":"") $2;$2=$3;$3=$4;$4=$5;$5=temp; print}' $1 > `echo $1 | sed 's/\.cod$/.bed/'`
