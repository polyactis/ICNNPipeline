#!/bin/bash - 
#===============================================================================
#
#          FILE:  Casava.makeFastq.sh
# 
#         USAGE:  ./Casava.makeFastq.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (NT), ntran@mednet.ucla.edu
#       COMPANY: ICNN, UCLA
#       CREATED: 04/04/2010 06:59:28 AM PDT
#      REVISION:  ---
#===============================================================================

#$ -cwd

set -o nounset                              # Treat unset variables as an error

if [ "x`echo $PATH | grep -o PIPELINE | uniq`" != "xPIPELINE" ]; then
    export PATH=.:~/PIPELINE/bin:$PATH
fi

for i in "$@" ; do
    echo $i
    in=$i
    d=`dirname $in`
    f=`basename $in _export.txt`    
    awk '{printf("@%s:%s:%s:%s:%s:%s:%s:%s\n%s\n+\n%s\n",$1,$2,$3,$4,$5,$6,$7,$8,$9,$10)}' $in > $d/$f.fastq
    randomFastq.sh $d/$f.fastq 10000
    Nullify.sh $d/$f.fastq 84
done
