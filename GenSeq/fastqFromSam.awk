#!/usr/bin/awk -f
{
    seq = and($2,0x0010)? reverseComp($10) : $10
    qual = and($2,0x0010)? reverse($11) : $11
    print "@" $1 "\n" seq "\n+\n" qual
}
function reverse(s)
{
    r = ""
    for(i=length(s); i > 0; i--) { 
        r = r substr(s, i, 1)
    }
    return r
}
function reverseComp(s)
{
    comp["A"] = "T"
    comp["C"] = "G"
    comp["G"] = "C"
    comp["T"] = "A"
    comp["a"] = "T"
    comp["c"] = "G"
    comp["g"] = "C"
    comp["t"] = "A"
    comp["N"] = "N"
    comp["n"] = "N"
    r = ""
    for(i=length(s); i > 0; i--) { 
        r = r comp[substr(s, i, 1)]
    }
    return r
}

