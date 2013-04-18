#!/usr/bin/awk -f
{
	id = $4 ":" $7
	count[id] += $8
	len[id] += $10
}
END{
	for (id in count) {
		split(id,A,":")
		print A[1] "\t" A[2] "\t" count[id] "\t" len[id]
	}
}
