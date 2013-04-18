#$ -cwd

if [ $# -ne 2 ]; then
    echo $0 sam ref
    exit 1
fi

sam=$1
ref=$2

#scriptDir=/u/home/eeskin/namtran/Experiment/Genome/Freimer/Chlorocebus/ProbeSpecific/Read-DB/SCRIPT/
scriptDir=~/PIPELINE/bin

$scriptDir/parseSamGetRefSequenceHit.awk -f ~/PIPELINE/bin/reverseComp.awk $sam $ref > `basename $sam .sam`.refSeqHit
