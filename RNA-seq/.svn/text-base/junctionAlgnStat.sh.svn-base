#!/bin/bash - 
#===============================================================================
#
#          FILE:  junctionAlgnStat.sh
# 
#         USAGE:  ./junctionAlgnStat.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (NT), ntran@mednet.ucla.edu
#       COMPANY: ICNN, UCLA
#       CREATED: 03/09/2010 03:01:39 PM PST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

nseq=`awk 'BEGIN{ RS="\n@"}END{print NR}' sequence.fastq`
total=`wc -l Refseq.junctionAlgn| awk '{print $1}'`

unique=`awk '$14 ~ /^X0:i:1$/ && $15 ~ /^X1:i:0/{ count++}END{print count}' Refseq.junctionAlgn`

njunction=`wc -l Refseq.junctionAlgn.readCount | awk '{print $1}'`

echo $nseq $total $unique $njunction


