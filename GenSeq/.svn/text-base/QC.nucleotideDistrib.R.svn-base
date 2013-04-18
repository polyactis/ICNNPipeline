oneExperimentQualPlot <- function(nameList) {

#list of file containing numerical values representing ACGT  
name <- read.table(nameList,colClasses=c("character"))
N <- dim(name)[1]

print(nameList)
if (N <= 10) {
    W <- 2
    H <- ceiling(dim(name)[1]/2)
}
else {
    W <- floor(sqrt(N))
    H <- ceiling(N/W)
}

png(paste(nameList,"_nucleotide_boxplot.png",sep=""),width=480*W,height=300*H)
par(mfrow=c(H,W),cex=1.2)

for (i in 1:dim(name)[1]) {
	print(name[i,1])
        
	base <- read.table(paste(name[i,1],".base",sep=""))
    
	base <- apply(base,2,function(y) { x <- y[!is.na(y)]; v = rep(0,6); for (i in 1:6) { v[i] <- sum(x == i-1) /length(x)}; return(v) } )

barplot(base[2:6,],names.arg=c(1:dim(base)[2]),col=c("orange","green","blue","yellow","red"),ylab='proportion of nucleotides',xlab='base No.',main=gsub(".fastq.*$","",basename(name[i,1])),ylim=0:1)
}

dev.off()
}
