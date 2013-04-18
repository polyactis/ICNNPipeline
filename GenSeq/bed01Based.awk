#!/usr/bin/awk -f
BEGIN{
	OFS="\t"
}
{
	$2 = $2-1
	print
}
