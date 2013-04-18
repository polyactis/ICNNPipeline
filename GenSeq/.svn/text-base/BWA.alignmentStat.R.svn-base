oneBatch <- function(batchName,nameList,color) {
name <- read.table(nameList,colClasses=c("character","character"))
print(nameList)

for (i in 1:dim(name)[1]) {
	print(name[i,1])
	if (i==1) {
		total <- read.table(name[i,1])
	}
	else {
		total <- cbind(total,read.table(name[i,1]))
	}
}

colnames(total) <- name[,2]
mismatchPercent <- t(apply(total,2,function(x) { x[1:3]/x[5] } ))

xnames <- 1:dim(mismatchPercent)[2] - 1
if ( sum(mismatchPercent) < dim(mismatchPercent)[1] ) {
	mismatchPercent <- cbind(mismatchPercent,1 - apply(mismatchPercent,1,sum))
	xnames <- c(xnames,paste(">",dim(mismatchPercent)[2] - 2,sep=""))
}

png(paste(sub("\\..*$","",nameList),"_uniqueAlgn_mismatch.png",sep=""))
barplot(mismatchPercent,names.arg=xnames,beside=T,legend=name[,2],col=color,ylab="percentage of unique alignment",xlab="number of mismatches",space=c(0,1.5),main=batchName)
dev.off()

png(paste(sub("\\..*$","",nameList),"_hitCount.png",sep=""))
xnames <- c(0:10,">10")
hitCount <- apply(total,2,function(x){ x <- x[4:length(x)]; s <- sum(x); c(x[1:11]/s,1-sum(x[1:11])/s)})
barplot(t(hitCount),names.arg=xnames,beside=T,legend=name[,2],col=color,ylab="percentage of sequenced reads",xlab="alignment (hit) count",space=c(0,1.5),main=batchName)
dev.off()
}
