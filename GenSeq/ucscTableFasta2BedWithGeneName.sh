#!/bin/bash - 
#===============================================================================
#
#          FILE:  uscsExonSequence2Pairing.sh
# 
#         USAGE:  ./uscsExonSequence2Pairing.sh 
# 
#   DESCRIPTION: convert sequence fasta download from UCSC to bed
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (NT), ntran@mednet.ucla.edu
#       COMPANY: ICNN, UCLA
#       CREATED: 02/27/2010 09:08:47 PM PST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

regexp="s/^>[^ ]*refGene_\(N[MR]_[0-9]\+\)\(\>\|_[0-9]\+\)\+ range=\(chr[^:]*\):\([0-9]*\)-\([0-9]*\).*strand=\([-+]\).*$/\1\t\3\t\4\t\5\t\6/"
grep  ">" $1 | sed "$regexp" | ~/PIPELINE/GenSeq/replaceRefseqIDwithGeneID.awk refFlat.txt - | awk '{print $2 "\t" ($3-1) "\t" $4 "\t" $1 "\t" 0 "\t" $5 }' | sort | uniq 
