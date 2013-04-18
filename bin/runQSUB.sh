option=$1
shift
if [ "x$option" != "x0" ] && [ "x$option" != "x1" ]; then
    echo need option for runQSUB
    exit 1
fi
if [ "x$option" = "x0" ]; then
    echo running fake qsub in $PWD 
    export PATH=/bin:/usr/bin
    bash $@
else
    qsub $@
fi
