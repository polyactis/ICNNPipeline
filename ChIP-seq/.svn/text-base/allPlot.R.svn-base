batchName <- basename(getwd())

sampleList <- read.table("sampleList.txt")
sampleList <- sampleList[,1]
nsample <- length(sampleList)

graphics.off()

png("baseQuality.png",width=480*2,height=300*ceiling(nsample/2))
par(mfrow=c(ceiling(nsample/2),2))
baseQual.dev <- dev.cur()

png("nucleotide.png",width=480*2,height=300*ceiling(nsample/2))
par(mfrow=c(ceiling(nsample/2),2))
nucl.dev <- dev.cur()

for (sidx in 1:nsample){
  curDir = paste(sampleList[sidx],"/",sep="")
  print(curDir)
  algn.multi <- as.matrix(read.table(paste(curDir,"multi.Genomic.algn.bed",sep="")))
  rep.multi <- as.matrix(read.table(paste(curDir,"multi.inRep.Genomic.algn.bed",sep="")))

  N <- 10
  ratio <- rep(0,N+2)


  for (i in 1:N){
    ratio[i+1] <- sum(rep.multi[,1]==i)/sum(algn.multi[,1]==i)
  }

  ratio[N+2] <- sum(rep.multi[,1]>N)/sum(algn.multi[,1]>N)

  ratio <- t(as.matrix(ratio))
##########################
  algnStat <- as.matrix(read.table(paste(curDir,"algnStat.txt",sep="")))
  totalRead <- algnStat[1,1]
  algnStat <- algnStat[2:dim(algnStat)[1],]
  hitCount <- rep(0,12)
  hitCount[1] <- totalRead - dim(algnStat)[1]
  for(i in 1:10) {
    hitCount[i+1] <- sum(algnStat[,1] == i)
  }
  hitCount[12] <- sum(algnStat[,1] > 10)
  totalUniq <- hitCount[2]
  hitCount <- hitCount/totalRead
  
##########################
  maxMis <- max(algnStat[,2])
  mis <- rep(0,maxMis+1)
  uniqStat <- algnStat[algnStat[,1] == 1,]
  for (i in 0:maxMis){
    mis[i+1] <- sum( uniqStat[,2] == i )
  }
  mis <- mis/totalUniq
  
###########################
  qual <- read.table(paste(curDir,"sample10000.sequence.fastq.qual",sep=""))
  dev.set(baseQual.dev)
  boxplot(qual,names=1:dim(qual)[2],outline=F,col="orange",ylab="Phred quality score",xlab="base No.",main=sampleList[sidx],ylim=c(min(qual,na.rm=TRUE),max(qual,na.rm=TRUE)))

  nucl <- read.table(paste(curDir,"sample10000.sequence.fastq.base",sep=""))
  nucl <- nucl[,1:sum(apply(!is.na(nucl),2,sum) > 0)]
  nucl <- apply(nucl,2,function(x) { x <- x[!is.na(x)]; v = rep(0,6); for (i in 1:6) { v[i] <- sum(x == i-1) /length(x) ; v }})
  
  dev.set(nucl.dev)
  barplot(nucl[2:6,],names.arg=1:dim(nucl)[2],col=c("orange","green","blue","yellow","red"),ylab='proportion of nucleotides',xlab='base No.',main=sampleList[sidx],ylim=c(0,1))

#########################  
  chromHit <- as.matrix(read.table(paste(curDir,"chromHitCount.tsv",sep=""),row.names=1))
  chromHit <- chromHit[,1]
  chromHit <- chromHit/sum(chromHit)

 if (sidx==1) {
    batch.ratio <- ratio
    batch.hitCount <- hitCount
    batch.mis <- mis
    batch.chromHit <- chromHit
  }
  else {
    batch.ratio <- rbind(batch.ratio,ratio)
    batch.hitCount <- rbind(batch.hitCount,hitCount)
    batch.mis <- rbind(batch.mis,mis)
    batch.chromHit <- cbind(batch.chromHit,chromHit)
  }
}
dev.set(baseQual.dev)
dev.off()

dev.set(nucl.dev)
dev.off()

png("chromHit.png",width=1200,height=480)
batch.chromHit <- t(batch.chromHit)
for (i in 1:length(colnames(batch.chromHit))){
  colnames(batch.chromHit)[i] <- substring(colnames(batch.chromHit)[i],4)
}
barplot(batch.chromHit,beside=T,legend=sampleList,xlab="chromosome",ylab="percentage of unique alignments",ylim=c(0,max(batch.chromHit)),space=c(0,1.5),main=batchName)
dev.off()

png("hitCount.png",width=900,height=480)
barplot((batch.hitCount),beside=T,legend=sampleList,xlab="hit count",ylab="percentage of total reads",ylim=c(0,1),space=c(0,1.5),main=batchName,names.arg=c(0:10,">10"))
dev.off()

png("mismatch.png")
barplot((batch.mis),beside=T,legend=sampleList,xlab="mismatch count",ylab="percentage of unique alignment",ylim=c(0,1),space=c(0,1.5),main=batchName,names.arg=0:(dim(batch.mis)[2]-1))
dev.off()

png("repeat.png",width=900,height=480)
barplot(batch.ratio,beside=T,legend.text=sampleList,args.legend = list(x = "topleft"),xlab="hit count",ylab="percentage in repeats",ylim=c(0,1),space=c(0,1.5),main=batchName,names.arg=c(0:10,">10"))
dev.off()

png("coverage.png",width=900,height=480)
batch.coverage <- read.table("batchStatistics.xls",row.names=1,header=T)
temp <- rbind(batch.coverage["inputSequence",],batch.coverage["filtered_unique",])
temp <- rbind(temp,batch.coverage["filtered_unique",])
batch.coverage <- t(batch.coverage[c("promoter","genic","intergenic"),]/temp)
barplot(batch.coverage,beside=T,legend=sampleList,ylab="percentage",ylim=c(0,1),space=c(0,1),main=batchName)
dev.off()

