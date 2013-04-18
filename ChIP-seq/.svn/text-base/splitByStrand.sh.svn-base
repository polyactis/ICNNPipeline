#$ -cwd
name=`basename $1 .algn`
> $name.F.algn
> $name.R.algn
awk 'BEGIN{ name=ARGV[1]; sub(/\.algn$/,"",name); print name}{print $0 >> name "." $3 ".algn"}' $1
