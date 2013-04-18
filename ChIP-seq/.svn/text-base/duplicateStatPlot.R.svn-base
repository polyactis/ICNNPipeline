batchName <- basename(getwd())

sampleList <- read.table("sampleList.txt")
sampleList <- sampleList[,1]
nsample <- length(sampleList)

W <- 2
H <- ceiling(nsample/2)
png("duplicate_cum_prob.png",width=480*W,height=300*H)
par(mfrow=c(H,W))
dupCountDev <- dev.cur()

col <- c("red","green","blue","yellow","cyan","brown","magenta","orange","black")
        
for (sidx in 1:nsample){
  curDir = paste(sampleList[sidx],"/",sep="")
  dupCount <- read.table(paste(curDir,"duplicateCount.tsv",sep=""))
  ix <- sort(dupCount[,1],index.return=TRUE)$ix
  dupCount <- dupCount[ix,]
  cumSum <- cumsum(dupCount[,1]*dupCount[,2])
  cumSum <- cumSum/cumSum[length(cumSum)]
  plot(dupCount[,1],cumSum,log="xy",xlab="duplicate count",ylab="cummulative probability",main=sampleList[sidx])
}
dev.off()

