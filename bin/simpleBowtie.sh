##$ -cwd
##$ -l h_data=1024M
##$ -pe shared 3
##$ -o log
##$ -e log
#
#file=`echo $2 | grep -o [^\\/]*$`
#log=log/$file
#
#echo $file
#echo $log
#1>$log.out 2>$log.err /u/local/apps/bowtie/0.10.1/bowtie $1 \
#-v 2 -k 100 -t --best -q  $2 \
#--un  algn/$file.unaligned --max  algn/$file.spurious algn/$file.aligned
#

/u/local/apps/bowtie/0.10.1/bowtie $1 -v 2 -k 100 -t --best -q $2 --un $2.unaligned --max $2.multi $2.bowtieAlgn

#echo simple hit and mismatch counting ... >> $log.out
#perl multiAlgn2HitMistmatchCount.pl algn/$file.aligned > algn/$file.mismatch
#
#echo counting totals ... >> $log.out
#perl sumMismatchCount.pl algn/$file.mismatch > algn/$file.total
