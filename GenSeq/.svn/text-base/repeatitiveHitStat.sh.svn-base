#!/bin/bash - 
#===============================================================================
#
#          FILE:  repeatitiveHitStat.sh
# 
#         USAGE:  ./repeatitiveHitStat.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (NT), ntran@mednet.ucla.edu
#       COMPANY: ICNN, UCLA
#       CREATED: 03/13/2010 07:30:37 AM PST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

samtools view Genomic.algn.bam | getTagsByHitCount.awk 

