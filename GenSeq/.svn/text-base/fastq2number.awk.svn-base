#!/usr/bin/awk -f
BEGIN{
	printable="!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"
	for (i=1;i <= length(printable);i++) {
#		print i+32 "\t" substr(printable,i,1)
		A[substr(printable,i,1)] = i+31
	}
    
	nucl["A"] = 1 
	nucl["C"] = 2
	nucl["G"] = 3
	nucl["T"] = 4
	nucl["N"] = 5
   	nucl["a"] = 1 
	nucl["c"] = 2
	nucl["g"] = 3
	nucl["t"] = 4
	nucl["n"] = 5

	seqFile = ARGV[1] ".base"
	qualFile = ARGV[1] ".qual"
	system("> " seqFile)
	system("> " qualFile)
	maxLen = 0
}
NR%4==2{    charSeq = $1    }
NR%4==0{    
	seq =  nucl[substr(charSeq,1,1)]+0
	qual = A[substr($1,1,1)]+0
    
    readLen = length($1)
    if (readLen ==0) {
        print
        next
    }
	if (readLen-maxLen>0) {
		maxLen = readLen
	}
	for(i=2;i<=length($1);i++) {
		seq = seq " " (nucl[substr(charSeq,i,1)]+0)
		qual = qual " " A[substr($1,i,1)]+0		
	}
    S[NR] = seq
    Q[NR] = qual
    L[NR] = readLen
}
END {    
    for (i=4; i <= NR; i += 4) {
        for (j=0; j < maxLen-L[i]; j++) {
            S[i] = S[i] " NA"
            Q[i] = Q[i] " NA"
        }
        print S[i] >> seqFile
        print Q[i] >> qualFile
    }
}
