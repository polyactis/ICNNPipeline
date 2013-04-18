#!/usr/bin/awk -f
BEGIN{
	RS=">"
	FS="\n"
    getline
}
{
    gsub(/ +/,"#",$1)
    seq = $2;
    for(i=3;i<NF;i++)
        seq = seq $i
    print $1 "\t" seq 
}
