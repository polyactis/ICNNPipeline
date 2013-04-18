#!/usr/bin/awk -f
BEGIN{
    getline
    chr = $1; start = $2; end = $3; gene = $4; strand = $6
}
{
#    print "prev:" chr "\t" start "\t" end "\t" gene "\t" 0 "\t" strand
#    print "now:" $0
    if (chr == $1 && gene == $4 && strand == $6) {
#       print "debug 1:" chr "\t" start "\t" end "\t" gene "\t" 0 "\t" strand
#        print "debug 1.5:" end "\t" $3
        if (end - $2 > 0) {
            end = ($3-end>0)?$3:end
#            print "debug 2:" chr "\t" start "\t" end "\t" gene "\t" 0 "\t" strand
            next
        }
    }
    print chr "\t" start "\t" end "\t" gene "\t" 0 "\t" strand
    chr = $1; start = $2; end = $3; gene = $4; strand = $6
}

