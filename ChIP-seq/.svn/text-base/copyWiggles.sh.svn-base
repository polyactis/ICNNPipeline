#$ -cwd 
 
set -o nounset                              # Treat unset variables as an error
if [ "x`echo $PATH | grep -o PIPELINE | uniq`" != "xPIPELINE" ]; then
    export PATH=.:~/PIPELINE/bin:$PATH:/u/local/bin
fi

rm -rf Wiggles
mkdir Wiggles

#for i in `find -L . -type f -name Genomic.algn.bam.bai -printf "%h\n" | sed 's/^\.\///' | sort`; do
priority=0
for sample in `cat sampleList.txt`; do
    priority=$(($priority+1))
    color[1]="255,0,0"
    color[2]="0,0,255"
    color[3]="0,0,0"
    strand[1]=".F."
    strand[2]=".R."
    strand[3]="."
    longName[1]="forward"
    longName[2]="reverse"
    longName[3]="2-strand"
    for index in 1 2 3; do
        for f in $sample/rmDup.unique.Genomic${strand[$index]}readLen*wig.baseline*; do
            if [ -f "$f" ]; then
                header=`grep -m 1 -n track $f`
                line=`echo $header | awk -F":" '{print $1}'`
                newWig=Wiggles/$sample.`basename $f`
                echo "browser position" `grep -m 1 -v chrM $sample/rmDup.unique.Genomic.bed | awk '{print $1 ":" $2 "-" $3}'` > $newWig
                header=`echo $header | sed -e 's/^[0-9]*://' -e "s/name=[^ ]\+/name=$sample.${longName[$index]}/" -e "s/priority=[^ ]\+/priority=$((10*$priority+$index))/" -e 's/color=[^ ]\+//'`
                echo $header color=${color[$index]} >> $newWig
                awk -v line=$line 'NR>line' $f >> $newWig
            fi
        done
    done
done


