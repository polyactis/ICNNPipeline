#$ -cwd 
#$ -V
set -eux


for i in *fastq; do d=`basename $i .fastq`; rm -rf $d; mkdir $d; cd $d; ln -s ../`basename $i` sequence.fastq; cd -; done

for d in `find -L . -name sequence.fastq -printf "%h\n"`; do
    pushd $d > /dev/null
    qsub ~/PIPELINE/bin/randomFastq.sh `pwd`/sequence.fastq 10000

    partDir=sequence.split
    mkdir -p $partDir
    
    nline=4000000
    qsub -b y -cwd -V split -l $nline -d sequence.fastq $partDir/sequence.fastq.part
    
    popd > /dev/null
done


