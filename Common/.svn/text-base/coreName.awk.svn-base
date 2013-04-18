#!/usr/bin/awk -f
BEGIN{
	if (length(ARGV) < 3)	
		exit
	for(i=1;i<length(ARGV[1]);i++) {
		delete temp
		for(j=1;j<length(ARGV);j++) {
			temp[substr(ARGV[j],i,1)]++
		}	
		count[i] = length(temp)
	}
	while (count[++start] == 1) {}	
	end = length(count)+1
	while (count[end-1] == 1) { end--}
	str = substr(ARGV[1],start,end-start)
	for(i=2; i < length(ARGV); i++) 
		str = str " " substr(ARGV[i],start,end-start)
	print str
}
