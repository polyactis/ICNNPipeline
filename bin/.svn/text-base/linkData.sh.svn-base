if [ $# -ne 1 ]; then
    echo $0 source_dir
    exit 1
fi

source=$1
for i in `find -L $source -type f`; do
    d=`dirname $i | sed 's/^[^a-zA-Z0-9]*//'`
    mkdir -p $d
    pushd $d > /dev/null
    ln -s $i
    popd > /dev/null
    echo $i
done

dest=`echo $source | sed 's/^[^a-zA-Z0-9]*//'`
mv $dest .
rmdir -p `dirname $dest`

dest=`basename $dest`
ndir=`ls $dest | wc -l`
while [ $ndir -eq 1 ]; do
    pushd $dest > /dev/null
    lower=`ls`
    mv $lower ..
    popd > /dev/null
    rmdir $dest
    dest=$lower
    ndir=`ls $dest | wc -l`
done


