#! /usr/bin/awk -f
BEGIN{  for(i=1;i<readLen;i++)  hist[i]=0 }
{
    hist[$8-$2]++
}
END{
    str=hist[1]
    for(i=2;i<readLen;i++){
        str = str "\t" hist[i]
    }
    print str
}

