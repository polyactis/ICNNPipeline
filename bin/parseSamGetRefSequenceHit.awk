#! /usr/bin/awk -f
FILENAME == ARGV[1] && NF > 11 {
    probe[$1] = (and($2,0x0010)? reverseComp($10) : $10)
    seqList[$1] = $3 "," (and($2,0x0010) ? "-" : "+") $4 "," $6 ";"
    needed[$3] = 1

    for (i=12; i<=NF; i++) {
        if ( $i ~/^XA:Z:/ ) { 
            break 
        }
    }
    if (i > NF) next 

    sub(/XA:Z:/,"",$i)
    seqList[$1] = seqList[$1] $i

    split($i,hit,";")
    
    for (j=1; j < length(hit); j++) {
        split(hit[j],A,",")
        needed[A[1]] = 1
    }
}
FILENAME == ARGV[2] {
    if ( $1 ~ /^>/ ) {
        id = substr($1,2)
    }
    else {
        if ( needed[id] != "" ) {
            fasta[id] = $1
        }
    }
}
END {
    for (k in seqList) {
#        print k "\t" seqList[k]
        split(seqList[k],list,";")
        hitRefSeq = ""
        for (i=1; i< length(list); i++) {
            split(list[i],A,",")
            refSeq = fasta[A[1]]
            pos = substr(A[2],2)
            if ( substr(A[2],1,1) == "-" ) {
                refSeq = reverseComp(refSeq)
                pos = length(refSeq) - pos - length(probe[k]) + 2 
            }
            hrs = extractHitRefSeq(substr(refSeq,pos),A[3])
#            print i "\t" A[2] "\t" A[4] "\t" refSeq "\t" pos "\t" A[3] "\t" hrs
            hitRefSeq = hitRefSeq "\t" hrs 
        }
        print k "\t" probe[k] "\t" hitRefSeq
    }
}

function extractHitRefSeq(sequence,cigar, len,op,ret,lastPos) {
    ret = ""
    indel = ""
#    print "extractHitRefSeq:" sequence "\t" cigar
    while ( cigar != "" ) 
    {
        if ( match(cigar,"^[0-9]+[MID]") ) {
            len = substr(cigar,RSTART,RLENGTH-1)
            op = substr(cigar,RSTART+RLENGTH-1,1)
            cigar = substr(cigar,RSTART+RLENGTH)
#            print cigar "\t" len "\t" op "\t" ret
            if ( op == "M" ) {
                ret = ret substr(sequence,1,len)
                sequence = substr(sequence,len+1)
                lastPos += len
            }
            if ( op == "I" ) {
                indel = indel lastPos "^" len op
                dummy = substr(ret sequence,1,len)
                gsub(/./,"*",dummy)
                ret = ret dummy
                lastPos += len
            }
            if ( op == "D" ) {
                indel = indel lastPos "^" len op
                sequence = substr(sequence,len+1)
            }
        }
        else {
            return "-"
        }
    }
    return ret "," indel
}
