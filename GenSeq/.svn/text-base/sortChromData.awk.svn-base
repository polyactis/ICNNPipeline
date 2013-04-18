#! /usr/bin/awk -f
{   chrNum = ($1 ~ /chr/)?substr($1,4):$1
    data[chrNum] = $0
}
END {
    for (i=0; i < 1000; i++) {
        if (data[i]){
            print data[i]
            delete data[i]
        }
    }
    other="XYM"
    for (i=1; i<=length(other); i++) {
        chr = substr(other,i,1) 
        if ( data[chr] )
        print data[chr]
        delete data[chr]
    }
    for (i in data) {
        if ( data[i]) {
            print data[i]
        }
    }
}
