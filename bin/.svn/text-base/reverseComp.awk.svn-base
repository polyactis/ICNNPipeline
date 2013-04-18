function reverseComp(s, i,comp,r,c)
{
    comp["A"] = "T"
    comp["C"] = "G"
    comp["G"] = "C"
    comp["T"] = "A"
    comp["a"] = "t"
    comp["c"] = "g"
    comp["g"] = "c"
    comp["t"] = "a"
    r = ""
    for(i=length(s); i > 0; i--) { 
        c = comp[substr(s, i, 1)]
        r = r ( c == "" ? substr(s, i, 1) : c )
    }
    return r
}

