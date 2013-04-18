#!/usr/bin/awk -f
# output: symbol	averageCount	averageLength	numberOfRefseq
{
	id = $1
	count[id] += $3
	len[id] += $4
	nref[id]++
}
END{
	for (id in count) {
		print id "\t" int(count[id]/nref[id]) "\t" len[id]/nref[id] "\t" nref[id]
	}
}
