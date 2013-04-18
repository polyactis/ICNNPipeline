#! /usr/bin/awk -f 
BEGIN {
    initLetterCode()
}
NR%2==1 && /^>/ {
    id = $1
}
NR%2==0 && !/^>/ {
    seq = $1
    for (frame=1; frame<=3; frame++) {
        prot = ""
        for (i=1; i+2 < length(seq); i +=3) {
            c = letter[substr(seq,i,3)]
            prot = prot (length(c) == 1? c : ".")
        }
        print id " 5'frame" frame-1 "\n" prot
        seq = substr(seq,2)
    }
    seq = reverseComp($1)
    for (frame=1; frame<=3; frame++) {
        prot = ""
        for (i=1; i+2 < length(seq); i +=3) {
            c = letter[substr(seq,i,3)]
            prot = prot (length(c) == 1? c : ".")
        }
        print id " 3'frame" frame-1 "\n" prot
        seq = substr(seq,2)
    }
 
}
function reverseComp(s)
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
        r = r comp[substr(s, i, 1)]
    }
    return r
}

function initLetterCode() {
    letter["ATT"] = "I"
    letter["ATC"] = "I"
    letter["ATA"] = "I"
    letter["CTG"] = "L"
    letter["TTA"] = "L"
    letter["TTG"] = "L"
    letter["CTT"] = "L"
    letter["CTC"] = "L"
    letter["CTA"] = "L"
    letter["GTG"] = "V"
    letter["GTT"] = "V"
    letter["GTC"] = "V"
    letter["GTA"] = "V"
    letter["TTT"] = "F"
    letter["TTC"] = "F"
    letter["ATG"] = "M"
    letter["TGT"] = "C"
    letter["TGC"] = "C"
    letter["GCG"] = "A"
    letter["GCT"] = "A"
    letter["GCC"] = "A"
    letter["GCA"] = "A"
    letter["GGG"] = "G"
    letter["GGT"] = "G"
    letter["GGC"] = "G"
    letter["GGA"] = "G"
    letter["CCG"] = "P"
    letter["CCT"] = "P"
    letter["CCC"] = "P"
    letter["CCA"] = "P"
    letter["ACG"] = "T"
    letter["ACT"] = "T"
    letter["ACC"] = "T"
    letter["ACA"] = "T"
    letter["TCG"] = "S"
    letter["AGT"] = "S"
    letter["AGC"] = "S"
    letter["TCT"] = "S"
    letter["TCC"] = "S"
    letter["TCA"] = "S"
    letter["TAT"] = "Y"
    letter["TAC"] = "Y"
    letter["TGG"] = "W"
    letter["CAA"] = "Q"
    letter["CAG"] = "Q"
    letter["AAT"] = "N"
    letter["AAC"] = "N"
    letter["CAT"] = "H"
    letter["CAC"] = "H"
    letter["GAA"] = "E"
    letter["GAG"] = "E"
    letter["GAT"] = "D"
    letter["GAC"] = "D"
    letter["AAA"] = "K"
    letter["AAG"] = "K"
    letter["CGG"] = "R"
    letter["AGA"] = "R"
    letter["AGG"] = "R"
    letter["CGT"] = "R"
    letter["CGC"] = "R"
    letter["CGA"] = "R"
    letter["TAA"] = "*"
    letter["TAG"] = "*"
    letter["TGA"] = "*"
}
