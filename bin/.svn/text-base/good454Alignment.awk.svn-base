#! /usr/bin/awk -f
{
    AScore = getAScore()
    XScore = getSubScore()

    if ( AScore < 200 || XScore > 100 ) {
        next
    }    
    
    if (length(align[$1]) == 0) {
        align[$1] = $0
        score[$1] = AScore
    }
    else 
        if ( score[$1] < AScore) {
            align[$1] = $0
            score[$1] = AScore
    }

}
END {
    for (i in align) {
        print align[i]
    }
}
function getAScore() {
    for (i=12; i <= NF; i++) {
        if ( match($i,/AS:i:[0-9]*$/) ) break
    }
    if ( i <= NF ) {
        return substr($i,RSTART+5,RLENGTH-5)+0        
    }
    else {
        return 0 
    }
}

 function getSubScore() {
    for (i=12; i <= NF; i++) {
        if ( match($i,/XS:i:[0-9]*$/) ) break
    }
    if ( i <= NF ) {
        return substr($i,RSTART+5,RLENGTH-5)+0        
    }
    else {
        return 0 
    }
}

   
