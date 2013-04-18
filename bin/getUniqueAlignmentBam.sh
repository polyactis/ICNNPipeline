#$ -V
#$ -b
#$ -cwd
#$ -l h_data=4G

set -eux

ref=$1
bam=$2

out=`dirname $bam`/unique.`basename $bam`

samtools view $bam | grep "\<X0:i:1\>" | grep "\<X1:i:0\>" | samtools view -Sb -t $ref.fai - > $out

temp=`getTempRandName.sh`
samtools sort $out $temp
mv $temp.bam $out
samtools index $out 


