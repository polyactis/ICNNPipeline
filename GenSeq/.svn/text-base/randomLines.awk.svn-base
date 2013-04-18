#! /usr/bin/awk -f
BEGIN{
    if ( nsample == 0 || total == 0 ) {
        print "input parameter(s) empty"
        exit
    }
	srand(systime());
	for(i=0;i<nsample;i++) {
		r = int(rand()*total)+1
		selected[r]++
	}
}
{
	if ( selected[NR] ) {
        for (i=0;i<selected[NR];i++) {
            lines[++count] = $0
        }
		if (count >= nsample) exit
	}
}
END{
    for (K=nsample; K>0; K--) {
        r = int(rand()*K) + 1
        print lines[r]
        lines[r] = lines[K]
    }
}
