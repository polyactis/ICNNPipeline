#$ -cwd

set -e

if [ $# != 1 ]; then
    echo $0 sam
    exit 1
fi

. ~/PIPELINE/bin/setGlobalEnv.sh

extractAlignedReferenceSequencesFromSam.awk -f ~/PIPELINE/bin/reverseComp.awk $1 > `dirname $1`/`basename $1 .sam`.algnRef 


