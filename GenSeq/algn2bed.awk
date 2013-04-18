#!/usr/bin/awk -f
BEGIN{
	strand["F"]= "+"
	strand["R"]= "-"
}
{
	print $1 "\t" $2-1 "\t" $2+readLen "\t" NR "\t" 0 "\t" strand[$3]
}
