#$ -cwd
#$ -l h_data=1G

. ~/PIPELINE/bin/setGlobalEnv.sh

if [ $# -ne 3 ]; then 
    echo $0 genome query ./L/LS \(local alignment option\)
    exit 1
fi

echo command: $0 "$@" 1>&2
echo cwd: `pwd` 1>&2

ref=$1
fasta=$2

out=`echo $ref | sed -e 's/^\.//' -e 's/\//__/g'`
out=$fasta-$out.$3.gff
if [ $3 == "." ]; then
    LS=""
else
    LS="-$3"
fi


echo started "spaln -M -ya $LS -Q7 -n20 -O0 -o$out -d$ref $fasta"

spaln -M -ya3 $LS -Q7 -n20 -O0 -o$out -d$ref $fasta > /dev/null 2>&1

echo done: "spaln -M -ya $LS -Q7 -n20 -O0 -o$out -d$ref $fasta"
