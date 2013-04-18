#$ -V
#$ -cwd 

source error_handling.sh

start_script

for d in `find -L . -name .algn -printf "%h\n" | tee .qsubAlignments.list`; do

    echo changing to $d ...
    pushd $d > /dev/null

    ref=`grep "^ref=" .params | cut -d'=' -f2`
    query=`grep "^query=" .params | cut -d'=' -f2`

    echo "INFO aligning $query to $ref"
    
    for f in `ls $query/sequence.fastq.part[0-9]*`; do
        a=`basename $f`.algn
        rm -rf $a && mkdir $a
        pushd $a > /dev/null
        Q=file.fastq
        ln -s $f $Q
        qsub `which rnaseq.singleEndAlignmentBWA.sh` $ref $Q
        popd > /dev/null
        break
    done

    popd > /dev/null
done

end_script
