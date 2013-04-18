#!/usr/bin/awk -f

BEGIN{
	printable="!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"
	split(printable,table,"")
	for(i=1;i<length(table);i++){
		asciiCode[table[i]]=i+32
	}
}	
{   
        qual = ""
        split($1,Q,"")
        for (i=1; i<=length(Q); i++) {
            qual=asciiCode[Q[i]]-31-32
	    if(qual > 20) {
		sum1 += 1 
	    }
	    if(qual > 30) {
           	sum2 += 1
	    }
        }
}
END{print sum1 "\t" sum2}

