#!/bin/bash - 
#===============================================================================
#
#          FILE:  countJunctionCoverage.sh
# 
#         USAGE:  ./countJunctionCoverage.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (NT), ntran@mednet.ucla.edu
#       COMPANY: ICNN, UCLA
#       CREATED: 03/09/2010 11:25:45 AM PST
#      REVISION:  ---
#===============================================================================

#$ -cwd
set -o nounset                              # Treat unset variables as an error

bin=~/PIPELINE/bin

refseqAlgn=Refseq.junctionAlgn

# extract unique alignment tags, filter them from refseq algn, count coverage of junctions
cut -f 4 uniqueGenomicAlgn.bed | $bin/diff.awk - $refseqAlgn |  $bin/countJunctionCoverage.awk > $refseqAlgn.readCount


