#!/usr/bin/awk -f
{
	split($10,exonStart,",")
	split($11,exonEnd,",")
	for(i=1; i < $9;i++) {
		print $3 "\t" exonEnd[i] "\t" exonStart[i+1] "\t" $1 "\t" 0 "\t" $4 "\t" $2
	}
}
