echo 
echo start ...
date
set -eux
pushd ~/PIPELINE
svn ci -m ''
svn add `svn st | awk '$1 == "?" && $2 !~ /(^|\/)\./{print $2}'`
svn ci -m ''
popd

