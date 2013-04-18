minListVal <- function(L) {
  min(unlist(lapply(L,function(x){ min(x[,2])})))
}

maxListVal <- function(L) {
  max(unlist(lapply(L,function(x){ max(x[,2])})))
}

smooth <- function(X) {
  ws <- 100
  shift <- ws/4
  
  left <- min(X[,1])
  right <- max(X[,1])
              
  range <- left:right
        
  T <- as.matrix(rep(0,length(range)))

  T[X[,1]-left+1] <- X[,2]

  middlePoint <- seq(ws/2,length(T)-ws/2,shift)
  meanVal <- rep(0,length(middlePoint))

  for (i in 1:length(middlePoint)) {
    m <- middlePoint[i]
    meanVal[i] <- mean(T[(m-ws/2+1):(m+ws/2)])
  }
  middlePoint <- middlePoint + left - 1
  cbind(middlePoint,meanVal)
}

tssBindPlot <- function(strand) {

  label <- as.matrix(c(".F",".R",""))
  rownames(label) <- c("forward","reverse","combined")
  
  png(paste(strand,"_point_TSS_bind.png",sep=""),width=500*2,height=500*ceiling(nsample/2))
  par(mfrow=c(ceiling(nsample/2),2),oma=c(0,0,3,0))
  pointDev <- dev.cur()

  TSS <- list()
  GENE <- list()
  for (sidx in 1:nsample){
    curDir = paste(sampleList[sidx],"/",sep="")

    count <- read.table(paste(curDir,"rmDup.unique.Genomic",label[strand,1],".tssBindCount",sep=""))
    count <- count[,-3] #this column is not necessary - the number of elements contributing to the total - see aggregate.awk

    plot(count[,1],count[,2],xlab='bp distance relative to TSS',ylab="total read count",main=sampleList[sidx])

    count[,2] <- count[,2]/sum(count[,2])
    TSS <- c(TSS,list(smooth(count)))
  }
  mtext(strand,line=1,side=3,outer=T,cex=2)
  dev.off()
  
  sz=600
  png(paste(strand,"_line_TSS_bind.png",sep=""),width=sz,height=sz)

  tss.ylim = c(minListVal(TSS),maxListVal(TSS))

  plot(TSS[[1]],type="l",col=col[1],ylim=tss.ylim,xlab="relative distance to TSS",ylab="normalized read count",main=strand,cex=1.2)
  for (i in 2:length(TSS)) {
    lines(TSS[[i]][,1],TSS[[i]][,2],col=col[i],xaxt="n",yaxt="n")
  }
  legend(x="topright",as.vector(sampleList),lwd=2,col=col[1:nsample])
  dev.off()

}

batchName <- basename(getwd())

sampleList <- read.table("sampleList.txt")
sampleList <- sampleList[,1]
nsample <- length(sampleList)

png("duplicate_cum_prob.png",width=2000,height=1600)
nsqrt <- ceiling(sqrt(nsample))
par(mfrow=c(nsqrt,ceiling(nsample/nsqrt)))
par(cex=1.25)
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

#tssBindPlot("forward")
#tssBindPlot("reverse")
#tssBindPlot("combined")
