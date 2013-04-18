#!/usr/bin/awk -f
BEGIN{
	RS="@"; FS="\n"; getline
}
{
	print "@" $1 "\n" substr($2,1,len) "\n+\n" substr($4,1,len)
}
