#!/usr/bin/awk -f
BEGIN{
	RS="\n>"
	FS="\n"
}
{
	if (match($1,"refGene_[^ ]*") ) {
		id = substr($1,RSTART+8,RLENGTH-8)
		seq = $2;
		for(i=3;i<=NF;i++)
			seq = seq $i
		print id "\t" seq 
	}
	else {
		next
	}
}
