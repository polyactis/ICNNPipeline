name <- read.table(nameList,colClasses="character")

N <- dim(name)[1]

png(file=paste(nameList,".png",sep=""),height=1000,width=500*N)
par(mfcol=c(2,N))

for (i in 1:N) {
  print(name[i,1])
  f <- basename(name[i,1])
  d <- dirname(name[i,1])
  d <- basename(d)
  title <- paste(f,d,sep=".")
  X <- read.table(name[i,1])
  hist(X[,2],main=paste(title," - average mismatch",sep=""))
  hist(X[,4],main=paste(title," - coverage",sep=""))
}
  
dev.off()
