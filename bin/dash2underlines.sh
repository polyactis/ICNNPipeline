tempFile=`dirname $1`.`getTempRandName.sh`.`basename $1`

sed 's/#/__/g' $1 > $tempFile
mv $tempFile $1
