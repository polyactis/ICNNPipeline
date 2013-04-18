#! /usr/bin/awk -f 
$3 != "*" && $10 != "N" {
    query = $10
    cigar = $6
    algn = ""
    while ( match(cigar,/^[0-9]+[MID]/) ) {
        str = substr(cigar,1,RLENGTH-1)
        op = substr(cigar,RLENGTH,1)
        if ( op == "M" ) {
            algn = algn substr(query,1,str)
            query = substr(query,str+1)
        }
        if ( op == "I" ) {
            dummy = substr(query,1,str)
            skip = gsub(/./,"*",dummy)
            algn = algn dummy
            query = substr(query,skip+1)
        }
        cigar = substr(cigar,RSTART+RLENGTH)
        #print query "\t" algn "\t" str "\t" op "\t" cigar
    }        
    
    for (i=NF; i>11; i--) {
        if ( match($i,/^MD:Z:/) ) {
            break
        }
    }
    if ( i == 11 ) next
    MD = substr($i,RSTART+5)

    ref = ""
    #print algn "\t" $10 "\t" MD "\t" $6 
    while (length(MD) > 0 && MD != 0) {
        if ( match(algn,/^[\*]+/) ) {
            ref = ref substr(algn,RSTART,RLENGTH)
            algn = substr(algn,RLENGTH+1)
        }
        if ( match(MD,/^[0-9]+/) || match(MD,/^[ACGT]/) || match(MD,/^\^[ACGT]+/) ) {
            str = substr(MD,RSTART,RLENGTH)
            if ( str != 0 && str - 0 > 0  && substr(MD,1,1) != "^" ) { # testing: str is a number not 0
                # insertion isn't counted
                len = str
                while ( len > 0 ) {
                    iden = substr(algn,1,len)
                    ref = ref iden
                    algn = substr(algn,len+1)
                    len = gsub(/\*/,"",iden)
                }
            }
            else {
                if ( length(str) == 1 && str != 0 ) {
                    ref = ref str
                    algn = substr(algn,2)
                }
                else {
                    if ( substr(MD,1,1) == "^" ) {
                        #print "ref insertion: " ins[$1] length(ref) substr(MD,RSTART,RLENGTH)
                        insLoc = and($2,0x0010) ? length($10) - length(ref) : length(ref)
                        insBase = substr(MD,1,1) (and($2,0x0010) ? reverseComp(substr(MD,2,RLENGTH-1)) : substr(MD,2,RLENGTH-1))
                        ins[$1] = (ins[$1] == "" ? "" : "\t") insLoc insBase
                    }
                }
            }
        }
        MD = substr(MD,RSTART+RLENGTH)
        #print ref "\t" str "\t" MD
    }
    #print "final:\t" ref "\t" $10 "\t" ins[$1] 
    print $1 "\t" (and($2,0x0010)? reverseComp(ref) : ref) "\t" ins[$1]
} 


