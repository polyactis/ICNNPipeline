oneExperimentQualPlot <- function(nameList,offset=0,color="orange") {

name <- read.table(nameList,colClasses="character")

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


png(paste(nameList,"_base_qual.png",sep=""),width=480*W,height=300*H)
par(mfrow=c(H,W),cex=1.2)

for (i in 1:dim(name)[1]) {
	print(name[i,1])
	qual <- read.table(paste(name[i,1],".qual",sep=""))
    qual <- qual -offset
	if (i==1) {
		medQ <- as.vector(apply(qual,2,median))
	}
	else {
		medQ <- cbind(medQ,as.vector(apply(qual,2,median)))
	}
	boxplot(qual,names=c(1:dim(qual)[2]),outline=F,col=color,ylab='base quality',xlab='base No.',main=gsub(".fastq.*$","",basename(name[i,1])),ylim=c(min(qual,na.rm=T),max(qual,na.rm=T)))
}
dev.off()
}

