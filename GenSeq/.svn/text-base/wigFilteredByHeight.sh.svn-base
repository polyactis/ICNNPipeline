#$ -cwd
#$ -l h_data=1024M
#$ -pe shared 4

set -o nounset                              # Treat unset variables as an error

if [ $# -ne 2 ]; then
    echo SYNOPSIS: `basename $0` wig baseline 
    exit
fi

if [ "x`echo $PATH | grep -o PIPELINE | uniq`" != "xPIPELINE" ]; then
    export PATH=.:~/PIPELINE/bin:$PATH
fi

wig=$1
baseline=$2

wigFilteredByHeight.awk -v baseline=$baseline $wig > $wig.baseline_$baseline 




