#!/bin/bash - 
#===============================================================================
#
#          FILE:  fixMetaRPKMWithFewerRows.sh
# 
#         USAGE:  ./fixMetaRPKMWithFewerRows.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (NT), ntran@mednet.ucla.edu
#       COMPANY: ICNN, UCLA
#       CREATED: 04/13/2010 05:12:19 PM PDT
#      REVISION:  ---
#===============================================================================

#$ -cwd
set -o nounset                              # Treat unset variables as an error

if [ "x`echo $PATH | grep -o PIPELINE | uniq`" != "xPIPELINE" ]; then
    export PATH=.:~/PIPELINE/bin:$PATH
fi

statFile=allStatistics.tsv
printf "exon_aligned\t%d\n" `awk 'NR==2{print $2}' unique.Genomic.algn.bed.coverageSum` >> $statFile
printf "junction_aligned\t%d\n" `awk 'NR==2{print $NF}' unique.Genomic.algn.bed.coverageSum` >> $statFile
