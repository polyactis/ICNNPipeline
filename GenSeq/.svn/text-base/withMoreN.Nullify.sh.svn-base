#!/bin/bash - 
#===============================================================================
#
#          FILE:  Nullify.sh
# 
#         USAGE:  ./Nullify.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (NT), ntran@mednet.ucla.edu
#       COMPANY: ICNN, UCLA
#       CREATED: 03/16/2010 05:01:15 AM PDT
#      REVISION:  ---
#===============================================================================

#$ -cwd
set -o nounset                              # Treat unset variables as an error

if [ $# -ne 2 ]; then
    echo SYNOPSIS: `basename $0` fastq qual
    exit
fi
 
~/PIPELINE/GenSeq/Nullify.awk -v q=$2 $1 > `dirname $1`/`basename $1 .fastq`.VarTrim$2.fastq 

