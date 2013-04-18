set -eu

mkdir -p $1
pushd $1 > /dev/null

d=Log.`date | sed 's/[: ]/_/g'`

mkdir -p $d

if [ -L Log ]; then
    oldLog=`ls -l Log | awk '{print $NF}'`
    rm -f Previous Log
    ln -s $oldLog Previous
else
    test -e Log && mv Log Log.moved.by.makeLogDir.script
fi

ln -s $d Log

echo $PWD/Log

popd > /dev/null
