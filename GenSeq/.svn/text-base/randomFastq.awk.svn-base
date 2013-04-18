#! /usr/bin/awk -f
BEGIN{
    if (length(ARGV) == 1) {
        print stdin not accepted
        exit
    }
    ("wc -l " ARGV[1] "| awk '{print $1}'") | getline total
    total = int(total/4)
	srand(systime());
	for(i=0;i<nsample;i++) {
		r = int(rand()*total)+1
		selected[r]++
	}
}
NR%4==1{    id = $1   }
NR%4==2{    seq = $1    }
NR%4==0{
    qual = $1
    recNum = (NR)/4
	if ( selected[recNum] ) {
        rec = id "\n" seq "\n+\n" qual
        for (i=0;i<selected[recNum];i++) {
            fastq[++count] = rec
        }
		if (count >= nsample) exit
	}
}
END{
    for (K=nsample; K>0; K--) {
        r = int(rand()*K) + 1
        print (substr(fastq[r],1,1)=="@"?"":"@") fastq[r]
        fastq[r] = fastq[K]
    }
}
