tempFile=`getTempRandName.sh`

echo nameList \<- \"$1\" > $tempFile
cat ~/PIPELINE/bin/plotConserveStat.R >> $tempFile

R CMD BATCH $tempFile

rm $tempFile
