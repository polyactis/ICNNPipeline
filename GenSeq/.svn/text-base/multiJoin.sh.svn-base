bin=`dirname $0` 
$bin/coreName.awk $@ | awk 'BEGIN{ OFS="\t" } { print "\t" $0}'
$bin/multiJoin.awk $@ | sort -k 1
