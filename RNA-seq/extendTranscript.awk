#!/usr/bin/awk -f
# output: symbol	averageCount	averageLength	numberOfRefseq
{
    if (FILENAME == ARGV[1]) {
        id = $1    
        count[id] += $3
        len[id] += $4
        nref[id]++
     }
     else {
         
     }
}
END{
	for (id in count) {
		print id "\t" int(count[id]/nref[id]) "\t" len[id]/nref[id] "\t" nref[id]
	}
}
