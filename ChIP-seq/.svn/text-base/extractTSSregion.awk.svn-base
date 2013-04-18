#! /usr/bin/awk -f
{
    if (count[$1] > 0)  next
    count[$1]++
    tss = $4 == "+" ? $5 : $6
    print $3 "\t" tss-2500 "\t" tss+2500 "\t" $1 "\t" 0 "\t" $4
}
