#!/usr/bin/awk -f
BEGIN {
    split(ind,A,",")
    if (length(A) == 0) {
        echo "ERROR: no index provided"
        exit 1
    }
    for(i=1;i<=length(A);i++)
        I[A[i]] = 1
}
NR%4==1 {
    id = $0
    split($2,temp,":")    
    getline seq
    getline
    getline qual
    if (I[temp[length(temp)]] == 1)
        print id "\n" seq "\n+\n" qual
}
