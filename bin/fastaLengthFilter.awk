#! /usr/bin/awk -f
NR%2==1 {
    id = $1
}
NR%2==0 {
    if ( length($1) >= minLen ) {
        print id "\n" $1
    }
}
    
