#! /usr/bin/awk -f
BEGIN {
    prevScore = 0
    while ( prevScore == 0 ) {
        getline
        prevID = $1
        prevAlgn = $0
        prevScore = getAScore()
    }
}
{
   if ($1 == prevID) {
       curScore = getAScore()

       if ( curScore > prevScore ) {
            prevID = $1
            prevAlgn[$1] = $0
            prevScore = curScore
       }
   }
   else {
        print prevAlgn[prevID]
    not yet finished
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

    
