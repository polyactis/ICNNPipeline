batchName <- basename(getwd())

sampleList <- read.table("sampleList.txt")
sampleList <- sampleList[,1]
nsample <- length(sampleList)

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
  coverage <- as.matrix(read.table(paste(curDir,"unique.Genomic.algn.bed.coverageSum",sep=""),header=T))
  totalUniq <- coverage[1]
  junctionAlgn <- coverage[length(coverage)]
  
  coverage <- coverage[2:(length(coverage)-1)]/totalUniq
##########################
  rcount <- read.table(paste(curDir,"combinedReadCount.tsv",sep=""),row.names=1)
  rpkm <- as.data.frame(1e+9 * rcount[,1])/rcount[,2]/totalUniq
  rpkm.rnames <- rownames(rcount)[rpkm > 0]
  rpkm <- as.matrix(rpkm[rpkm >0,1])
  rownames(rpkm) <- rpkm.rnames  

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

  chromHit <- read.table(paste(curDir,"chromHitCount.tsv",sep=""),row.names=1)
  chromHit <- chromHit/sum(chromHit)
  
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

    batch.chromHit <- cbind(batch.chromHit,chromHit)
    batch.algnGeneral <- rbind(batch.algnGeneral,algnGeneral)
  }

}


batch.algnGeneral <- as.matrix(batch.algnGeneral)
colnames(batch.algnGeneral) <- c("rRNA","repeat","exon","splice_junc.")
rownames(batch.algnGeneral) <- sampleList
write.table(batch.algnGeneral,file="batch.algnGeneral.tsv",quote=FALSE,row.names=TRUE)

batch.chromHit <- t(batch.chromHit)
rownames(batch.chromHit) <- sampleList
write.table(batch.chromHit,file="batch.chromHit.tsv",quote=FALSE,row.names=TRUE)

rownames(batch.hitCount) <- sampleList
write.table(batch.hitCount,file="batch.hitCount.tsv",quote=FALSE,row.names=TRUE)

rownames(batch.mis) <- sampleList
write.table(batch.mis,file="batch.mis.tsv",quote=FALSE,row.names=TRUE)

rownames(batch.ratio) <- sampleList
write.table(batch.ratio,file="batch.ratio.tsv",quote=FALSE,row.names=TRUE)

batch.coverage <- as.matrix(batch.coverage)
colnames(batch.coverage) <- c("exon","5utr","3utr","ex/intr","intron","gene","TSS","TES","intrg")
rownames(batch.coverage) <- sampleList
write.table(batch.coverage,file="batch.coverage.tsv",quote=FALSE,row.names=TRUE)


