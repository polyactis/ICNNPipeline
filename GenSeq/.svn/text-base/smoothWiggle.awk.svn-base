#!/usr/bin/awk -f
BEGIN{
	if (window == 0) {
		print "Error: window size not provided. Set it with -v window=some_value"
		exit 1
	}
	RS = "fixedStep chrom="
	FS = "\n"
	getline
	sub("\n$","",$0)
	sub("name=","name=smooth.",$0)
	print
}
{
	fieldHeader = $1
	sub("step=[0-9]*","step=" window " span=" window,fieldHeader)
	print RS fieldHeader
	q = int((NF-2)/window)
	n = q * window == NF - 2?q : q + 1
	for(i=0;i<n;i++) {
		start = 2+i*window;
		end = start + window;
		if ( end > NF )
			end = NF
		sum = 0
		for(j=start;j<end;j++) {
			sum += $j
		}
		mean = sum/(end-start)
		print mean
	}
}	
