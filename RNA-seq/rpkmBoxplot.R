oneExperimentPlot <- function(nameList,color="white") {

name <- read.table(nameList,colClasses=c("character","character","integer"))
print(nameList)
mainName <- sub("\\..*$","",nameList)
jpeg(paste(sub("\\..*$","",nameList),"_RPKM_boxplot.jpg",sep=""))

for (i in 1:dim(name)[1]) {
	print(name[i,1])
	count <- read.table(name[i,1],row.names=1)
	r <- as.matrix(log(count[,1]*1e+9/count[,2]/name[,3]))
	rownames(r) <- rownames(count)
	if (i==1) {
		rpkm <- r
	}
	else {
		row <- intersect(rownames(rpkm),rownames(r))
		rpkm <- cbind(rpkm[row,],r[row,])
	}
}
colnames(rpkm) <- name[,2] 
boxplot(rpkm,names=name[,2],col=color,main=mainName)
dev.off()
return(rpkm)
}

