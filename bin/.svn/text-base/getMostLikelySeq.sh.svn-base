nucl=$1
len=`awk '{print length($1)}' $nucl | sort -rn | head -1`
seq=""
for col in `seq 1 $len`; do base=`cut -b$col $nucl | awk '{print $1 "\t" 1}' | aggregate.awk | sort -k2,2rn | head -1 | cut -f1`; seq=$seq$base; done
echo $seq
for j in `seq 1 $len`; do
    for i in `seq $(($j+5)) $len`; do 
        motif=`echo $seq | cut -b$j-$i` 
        count=`grep -c $motif $nucl` 
        echo $motif $count
    done
done | sort -k2,2rn | less
