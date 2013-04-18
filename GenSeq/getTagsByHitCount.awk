#! /usr/bin/awk -f
{
    nhit = substr($14,6) + substr($15,6)
    file = nhit <= 10? nhit "hits.tag" : "11hits.tag"
    print $3 "\t" ($4-1) "\t" ($4-1+length($10))$1 >> file
}
