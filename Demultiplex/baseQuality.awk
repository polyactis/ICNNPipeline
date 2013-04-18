#!/usr/bin/awk -f

BEGIN{
	printable="!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"
	split(printable,table,"")
	for(i=1;i<length(table);i++){
		asciiCode[table[i]]=i+32
	}
}	
{   
        if($2==1) {
		qual = ""
	        split($1,Q,"")
		for (i=1; i<=length(Q); i++) {
        		sumTotal += 1 
	   		sumPassed +=1
			qual=asciiCode[Q[i]]-31-32
	    		if(qual > 20) {
				sumPass20 += 1 
	    			sumTot20 += 1
			}
	    		if(qual > 30) {
           			sumPass30 += 1
	    			sumTot30 += 1
			}	
        	}
	}
	else {
		qual = ""
	        split($1,Q,"")
		for (i=1; i<=length(Q); i++) {
                        sumTotal += 1
                        qual=asciiCode[Q[i]]-31-32
                        if(qual > 20) {
                                sumTot20 += 1
                        }
                        if(qual > 30) {
                                sumTot30 += 1
                        }
                }
	}
}
END{print (sumTotal+0) "\t" (sumTot20+0) "\t" (sumTot30+0) "\t" (sumPassed+0) "\t" (sumPass20+0) "\t" (sumPass30+0)}

