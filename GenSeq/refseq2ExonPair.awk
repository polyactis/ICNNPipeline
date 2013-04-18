#!/usr/bin/awk -f
{
	
	if (FILENAME == ARGV[1]) {
		exonStart[$2] = $10
		exonEnd[$2] = $11
#		print $2 "\t" $10 "\t" $11
		refseqCount[$2]++
	}
	else {
		id = $1
		if (refseqCount[id] > 1) {
			next
		}
		len = 0
		split(exonStart[id],start,",")
		split(exonEnd[id],end,",")
		for(i=1;i<length(start);i++) {
			len +=  end[i]-start[i]
		}
		if (len != length($2)) {
			next
#			print id "\t" len
		}		
		s=0
		delete exon
		for(i=1;i<length(start);i++){
			l = end[i]-start[i]
			exon[i] = substr($2,s+1,l)
			s += l;
		}
		for(i=1;i<=length(exon);i++) {
			print id ":" start[i] ":" end[i] ":" i "\t"  exon[i]
		}
#		for(i=1;i<length(exon);i++) {
#			for(j=i+1;j<length(exon);j++) {
#				print id ":" start[i] ":" end[i] ":" start[j] ":" end[j] "\t" exon[i] "\t" exon[j]
#			}
#		}		
	}
}
