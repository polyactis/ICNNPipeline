#!/usr/bin/awk -f
# input bam file
BEGIN{
	getline
	cur[1] = $3 #chromosome
	cur[2] = $4 #position
	prev[1] = cur[1]
	prev[2] = 0
	dupCount = 1
	line[dupCount++] = $0
}
{
	succ[1] = $3
	succ[2] = $4
#	print "prev=" prev[1] ":" prev[2] "\tcur=" cur[1]":"cur[2] "\tdupCount=" dupCount
	if ( succ[1] == cur[1] && succ[2] == cur[2] ) {
		line[++dupCount] = $0
		next
	}
	# if this is indeed a very isolated 1-length pileup, consider it as duplicates
	if (dupCount > 1 && succ[1] == cur[1] && cur[2]-prev[2]>gap && succ[2]-cue[2]>gap) {
	
		hist[dupCount]++ #histogram of duplicates

		delete line
		dupCount=1
		line[dupCount] = $0
	
		for(i in succ) {
			cur[i] = succ[i]		
		}

		if (cur[1] != prev[1]) { # now jump to another chromosome, reset prev
			prev[1] = cur[1]
			prev[2] = 0
		}
		next
	}
	for (i in line) {
		print line[i]
	}
	delete line
	for(i in cur) {
		prev[i] = cur[i]
		cur[i] = succ[i]
	}
	dupCount=1
	line[dupCount] = $0
}
END{
	if (dupCount == 1 || prev[1] != cur[1]  || cur[2]-prev[2]<=gap) { 
		for (i in line) {
			print line[i]
		}
	}
	file = ARGV[1] ".dupHist"
	system(">" file)
	n = asorti(hist,I)
	for (i=0;i<n;i++) {
		print I[i] "\t" hist[I[i]]	>> file
	} 
}
		
