cat $1 | sort | uniq -c | sed 's/\//\t/' | awk '$2 != $3' | tr ACGT 0123 | awk '{ is = $2%2 == $3%2; ti += $1*is; tv += $1*(1-is) }END{ printf("%d\t%d\t%.2f\n",ti,tv,ti/tv)}'
