#!/bin/bash - 
#===============================================================================
#
#          FILE:  Casava.export2fastq.sh
# 
#         USAGE:  ./Casava.export2fastq.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (NT), ntran@mednet.ucla.edu
#       COMPANY: ICNN, UCLA
#       CREATED: 03/29/2010 04:16:33 PM PDT
#      REVISION:  ---
#===============================================================================

#$ -cwd
set -o nounset                              # Treat unset variables as an error

awk '{printf("@%s:%s:%s:%s:%s:%s:%s:%s\n%s\n+\n%s\n",$1,$2,$3,$4,$5,$6,$7,$8,$9,$10)}' $1 > `dirname $1`/`basename $1 .txt`.fastq
