len=$1

echo intersecting with genes ...
cat refFlat.txt | awk '!/random/ && !/hap/{print $3 "\t" $5 "\t" $6 "\t" $1 "\t" 0 "\t" $4 "\t" $2}' > refFlat.bed

# expand regions in $1 with left and right $len buffer then intersectBed with $2
# the experiment.rmDupUnique.F.wiggle.bed produced by ~/PIPELINE/GenSeq/wiggle2FlatBed.awk
expandIntersectBed.sh experiment.rmDupUnique.F.wiggle.bed refFlat.bed $len $len u > inGene.experiment.rmDupUnique.F.wiggle.bed

echo filtering with control ...
dlen=$((2*$len))
# expand region in $1 with left and right $dlen buffer then "negatively" intersectBed with $2
expandIntersectBed.sh inGene.experiment.rmDupUnique.F.wiggle.bed control.rmDupUnique.wiggle.bed $dlen $dlen v > notCtrl.inGene.experiment.rmDupUnique.F.wiggle.bed

echo intersecting F and R ...
#awk -v len=$len 'BEGIN{OFS="\t"}{temp=$2; $2=$3; $3+=len; print $0 "\t" $temp}' notCtrl.inGene.experiment.rmDupUnique.F.wiggle.bed | intersectBed -a stdin -b experiment.rmDupUnique.R.wiggle.bed -wa -wb | awk '{print $1 "\t" $6 "\t" $9 "\t" $6+$11}' | sort -rn -k 4,4 > peaks.adhoc

awk -v len=$len 'BEGIN{OFS="\t"}{temp=$2; $2=$3; $3+=len; print $0 "\t" temp}' notCtrl.inGene.experiment.rmDupUnique.F.wiggle.bed | intersectBed -a stdin -b experiment.rmDupUnique.R.wiggle.bed -wa -wb | awk '{print $1 "\t" $6 "\t" ($9<$3?$9:$3) "\t" $5+$11}' | sort -rn -k 4,4 > peaks.adhoc_$len 

echo track name=\'adhoc_buffer$len peaks\' description=\'heuristic peak filtering\' color=0,255,0 > peaks.adhoc_$len.merged
mergeBed -i peaks.adhoc_$len >> peaks.adhoc_$len.merged

awk 'NR > 1{print $0 "\t" $3-$2}' peaks.adhoc_$len.merged | sort -k4rn > peaks.adhoc_$len.merged.lenSorted

#expandIntersectBed.sh notCtrl.inGene.experiment.rmDupUnique.F.wiggle.bed experiment.rmDupUnique.R.wiggle.bed 0 250 u | sort -rn -k 5,5 | head

