prefix <- 25:dim(x)[2]

total <- rep(0,length(prefix))
for (i in 1:length(prefix)) {
  total[i] = log(prefix[i])*sum(apply(x[,1:prefix[i]],1,min) > -10*log10(0.5/prefix[i]) + 64)
}

plot(prefix,total)
  
