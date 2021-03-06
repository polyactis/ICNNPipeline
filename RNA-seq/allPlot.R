batchName <- basename(getwd())
#fileList <- file.info(dir())
#sampleList <- rownames(fileList)[fileList$isdir]
#sampleList <- sampleList[!is.na(sampleList)]

sampleList <- read.table("sampleList.txt")
sampleList <- sampleList[,1]
nsample <- length(sampleList)

graphics.off()

png("baseQuality.png",width=2200,height=1600)
nsqrt <- ceiling(sqrt(nsample))
par(mfrow=c(nsqrt,ceiling(nsample/nsqrt)))
par(cex=1.25)
baseQual.dev <- dev.cur()

png("nucleotide.png",width=2200,height=1600)
par(mfrow=c(nsqrt,ceiling(nsample/nsqrt)))
par(cex=1.25)
nucl.dev <- dev.cur()

chromList <- read.table("chromList.tsv",colClass=c("character"))
  
for (sidx in 1:nsample){
  curDir = paste(sampleList[sidx],"/",sep="")

  print(curDir)

  print("reading multi.Genomic.algn.bed")
  algn.multi <- as.matrix(read.table(paste(curDir,"multi.Genomic.algn.bed",sep="")))

  print("reading multi.inRep.Genomic.algn.bed")
  rep.multi <- as.matrix(read.table(paste(curDir,"multi.inRep.Genomic.algn.bed",sep="")))

  N <- 10
  ratio <- rep(0,N+2)


  for (i in 1:N){
    ratio[i+1] <- sum(rep.multi[,1]==i)/sum(algn.multi[,1]==i)
  }

  ratio[N+2] <- sum(rep.multi[,1]>N)/sum(algn.multi[,1]>N)

  ratio <- t(as.matrix(ratio))
##########################

  print("reading unique.Genomic.algn.bed.coverageSum")
  
  coverage <- as.matrix(read.table(paste(curDir,"unique.Genomic.algn.bed.coverageSum",sep=""),header=T))
  totalUniq <- coverage[1]
  junctionAlgn <- coverage[length(coverage)]
  
  coverage <- coverage[2:(length(coverage)-1)]/totalUniq
##########################
#  rcount <- read.table(paste(curDir,"combinedReadCount.tsv",sep=""),row.names=1)
#  rpkm <- as.data.frame(1e+9 * rcount[,1])/rcount[,2]/totalUniq

  print("reading isof.rpkm.tsv")
  
  rpkm <- read.table(paste(curDir,"isof.rpkm.tsv",sep=""),row.names=1)
#  rpkm.rnames <- rownames(rpkm)[rpkm > 0]
#  rpkm <- as.matrix(rpkm[rpkm >0,1])
#  rownames(rpkm) <- rpkm.rnames  

##########################
  print("reading algnStat.txt")
  
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

  print("reading sample10000.sequence.fastq.qual")
  
  qual <- read.table(paste(curDir,"sample10000.sequence.fastq.qual",sep=""))
  qual <- qual[,1:sum(apply(!is.na(qual),2,sum) > 0)]
  dev.set(baseQual.dev)
  boxplot(qual,names=1:dim(qual)[2],outline=F,col="orange",ylab="Phred quality score",xlab="base No.",main=sampleList[sidx],ylim=c(min(qual,na.rm=TRUE),max(qual,na.rm=TRUE)))

  print("reading sample10000.sequence.fastq.base")
  
  nucl <- read.table(paste(curDir,"sample10000.sequence.fastq.base",sep=""))
  nucl <- nucl[,1:sum(apply(!is.na(nucl),2,sum) > 0)]
  nucl <- apply(nucl,2,function(x) { x <- x[!is.na(x)]; v = rep(0,6); for (i in 1:6) { v[i] <- sum(x == i-1) /length(x) ; v }})
  
  dev.set(nucl.dev)
  barplot(nucl[2:6,],names.arg=1:dim(nucl)[2],col=c("orange","green","blue","yellow","red"),ylab='proportion of nucleotides',xlab='base No.',main=sampleList[sidx],ylim=c(0,1))

#########################

  print("reading chromHitCount.tsv")
  chromHit <- read.table(paste(curDir,"chromHitCount.tsv",sep=""),row.names=1)
  chromHit <- chromHit/sum(chromHit)
  chromHit <- as.matrix(chromHit[chromList[,1],])
  chromHit[is.na(chromHit[,1]),1] <- 0
  rownames(chromHit) <- chromList[,1]

  print("reading moreAlgnStat.txt")
  moreAlgnStat <- read.table(paste(curDir,"moreAlgnStat.txt",sep=""),row.names=1)
  algnGeneral <- rep(0,4)
  algnGeneral[1] <- moreAlgnStat[2,1]
  algnGeneral[2] <- moreAlgnStat[3,1]  
  algnGeneral[3] <- coverage[1]*totalUniq
  algnGeneral[4] <- junctionAlgn
  algnGeneral <- algnGeneral/totalRead

  if (sidx==1) {
    batch.ratio <- ratio
    batch.coverage <- coverage
    batch.rpkm <- rpkm
    batch.hitCount <- hitCount
    batch.mis <- mis
    batch.chromHit <- chromHit
    batch.algnGeneral <- algnGeneral
  }
  else {
    batch.ratio <- rbind(batch.ratio,ratio)

    batch.coverage <- rbind(batch.coverage,coverage)
    batch.hitCount <- rbind(batch.hitCount,hitCount)
    batch.mis <- rbind(batch.mis,mis)

    sharedNames <- intersect(rownames(batch.rpkm),rownames(rpkm))
    batch.rpkm <- cbind(batch.rpkm[sharedNames,],rpkm[sharedNames,])
    rownames(batch.rpkm) <- sharedNames

    batch.chromHit <- cbind(batch.chromHit,chromHit)
    
    batch.algnGeneral <- rbind(batch.algnGeneral,algnGeneral)
  }

}

dev.set(baseQual.dev)
dev.off()

dev.set(nucl.dev)
dev.off()


png("rRNA_repeat_etc.png",width=1000,height=500)

batch.algnGeneral <- as.matrix(batch.algnGeneral)


colnames(batch.algnGeneral) <- c("rRNA","repeat","exon","splice junc.")

barplot(batch.algnGeneral,beside=T,legend=sampleList,ylab="percentage of total reads",ylim=c(0,1),space=c(0,1),main=batchName)
dev.off()


png("chromHit.png",width=1500,height=600)
batch.chromHit <- t(batch.chromHit)
for (i in 1:length(colnames(batch.chromHit))){
  colnames(batch.chromHit)[i] <- substring(colnames(batch.chromHit)[i],4)
}
barplot(batch.chromHit,beside=T,legend=sampleList,xlab="chromosome",ylab="percentage of unique alignments",ylim=c(0,max(batch.chromHit)),space=c(0,1.5),main=batchName)
dev.off()

png("hitCount.png",width=1000,height=600)
barplot((batch.hitCount),beside=T,legend=sampleList,xlab="hit count",ylab="percentage of total reads",ylim=c(0,1),space=c(0,1.5),main=batchName,names.arg=c(0:10,">10"))
dev.off()

png("mismatch.png",width=900,height=600)
barplot((batch.mis),beside=T,legend=sampleList,xlab="mismatch count",ylab="percentage of unique alignment",ylim=c(0,1),space=c(0,1.5),main=batchName,names.arg=0:(dim(batch.mis)[2]-1))
dev.off()

png("repeat.png",width=1500,height=600)
barplot(batch.ratio,beside=T,legend.text=sampleList,args.legend = list(x = "topleft"),xlab="hit count",ylab="percentage in repeats",ylim=c(0,1),space=c(0,1.5),main=batchName,names.arg=c(0:10,">10"))
dev.off()

png("coverage.png",width=1000,height=600)
batch.coverage <- as.matrix(batch.coverage)
colnames(batch.coverage) <- c("exon","5utr","3utr","ex/intr","intron","gene","TSS","TES","intrg")
#barplot(batch.coverage[,c(1,4:dim(batch.coverage)[2],2:3)],beside=T,legend=sampleList,ylab="percentage",ylim=c(0,1),space=c(0,1),main=batchName)
barplot(batch.coverage[,c(1,4:dim(batch.coverage)[2],2:3)],beside=T,ylab="percentage",ylim=c(0,1),space=c(0,1),main=batchName)
legend("topright",as.vector(sampleList),inset=c(0.3,0))
dev.off()

png("rpkmBoxplot.png",width=1500,height=600)
par(las=3)
batch.rpkm <- log2(batch.rpkm)
boxplot(batch.rpkm,names=sampleList,main=batchName)
dev.off()


#W <- 2
#H <- ceiling(nsample/2)
#png("qqnorm.png",width=480*W,height=300*H)
#par(mfrow=c(H,W))
#for (i in 1:nsample) {
#  qqnorm(batch.rpkm[,i],main=sampleList[i])
#}
#dev.off()

#npair <- nsample*(nsample-1)/2
#W = 1
#if ( npair > 4 ) {
#  W = 4
#}
#if ( npair <= 4 && npair > 1) {
#  W = 2
#}

#H <- ceiling(nsample*(nsample-1)/W/2)
#png("rpkmScatter.png",width=300*W,height=300*H)
#par(mfrow=c(H,W))

#axisRange <- c(min(batch.rpkm), max(batch.rpkm))
#textLoc <- c(0.95*axisRange[1] + 0.05*axisRange[2],0.05*axisRange[1] + 0.95*axisRange[2])
#colnames(batch.rpkm) <- sampleList
#CEX=1.2
#for (i in 1:(dim(batch.rpkm)[2]-1)) {
#        for (j in (i+1):dim(batch.rpkm)[2]) {
#               plot(batch.rpkm[,i],batch.rpkm[,j],pch='.',xlab=colnames(batch.rpkm)[i],ylab=colnames(batch.rpkm)[j],xlim=axisRange,ylim=axisRange)
#               c <- cor(batch.rpkm[,i],batch.rpkm[,j])
#               text(textLoc[1],textLoc[2],substitute(R^2==x,list(x=format(c*c,digits=2))),cex=CEX,adj=c(0,0.5))
#        }
#}
#dev.off()

