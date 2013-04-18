#!/usr/bin/awk -f
BEGIN{
	OFS = "\t"
}
{
	key = $1
	$1 = ""
	joined[key] = joined[key] $0
}
END{
	for (key in joined) {
		print key joined[key]
	}
}
