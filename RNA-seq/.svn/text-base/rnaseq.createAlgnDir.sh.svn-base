#$ -V
#$ -cwd 

function prepAlgnDir {
    mkdir -p $1
    pushd $1 > /dev/null
    > .algn
    echo "ref=$2" > .params
    echo "query=$3" >> .params
    popd
}

source error_handling

start_script

#ls .params
#refDir=`cat .params | grep -m1 "^refDir=" | sed 's/^refDir=\(.*\)$/\1/'`

if [ $# -ne 1 ]; then
    echo reference dir needed
    echo Example: ~/Data/RefGenome/RNA-seq/Human/hg19
    exit 1
fi

refDir=$1
ls -ld $refDir
echo "INFO reference is $refDir"

echo "refDir=$refDir" > .params

ln -sf $refDir REFERENCE

for sample in `find -L . -name sequence.fastq -printf "%h\n"`; do

    echo changing to $sample ...
    pushd $sample > /dev/null

    prepAlgnDir Genomic $refDir/genome.fasta `pwd`/sequence.split
    prepAlgnDir rRNA $refDir/rRNA.fasta `pwd`/sequence.split
    prepAlgnDir Refseq $refDir/spliceJunction.fasta `pwd`/sequence.split

    popd > /dev/null
done

end_script
