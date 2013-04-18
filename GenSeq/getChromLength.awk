#! /usr/bin/awk -f
{
    if (/^>chr/) {   
        chr = substr($1,2)
        next
    }
    len[chr] += length($1) 
}
END{
    for (i in len) {
        if (i)
            print i "\t" len[i]
    }
}

