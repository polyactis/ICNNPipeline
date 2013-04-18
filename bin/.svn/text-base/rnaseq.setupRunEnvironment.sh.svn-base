if [ $# -ne 2 ]; then
    echo specify: pipeline path "(~/PIPELINE/RNA-seq-...)" and mode "[development/production]"
    return 1
fi

scriptDir=$1
binDir=`dirname $scriptDir`/bin

mode=$2

debugModePath=/bin/:/usr/bin:/u/local/bin:/u/local/sbin
export RNASEQ_QSUB_MODE=yes

if [ $mode == "random10K" ]; then
    export PATH=$scriptDir:$binDir:$debugModePath
    export fastqSplitLineCount=2000

# faking qsub with bash
    export PATH=/u/home/eeskin/namtran/PIPELINE/Debug/bin:$PATH
    return 0
fi
if [ $mode == "debug_w_qsub" ]; then
    export PATH=$scriptDir:$binDir:$debugModePath
    export fastqSplitLineCount=2000
    return 0
fi

if [ $mode == "development" ]; then
    export PATH=$scriptDir:$binDir:$debugModePath
    export fastqSplitLineCount=1000000
    return 0
fi

if [ $mode == "production" ]; then
    export PATH=$scriptDir:$binDir:$PATH
    export fastqSplitLineCount=1000000
    return 0
fi

echo incorrect mode! environment may not be correct ... >& 2
return 1
