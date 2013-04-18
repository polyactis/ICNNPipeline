for file in $@; do
    b=`head $file | grep -m1 ^time: | cut -f2- -d' ' | xargs -I{} date +%s -d "{}"`
    e=`tail -2 $file | grep -m1 "^DONE" | cut -f4- -d' ' | xargs -I{} date +%s -d "{}"`
    echo $(($e-$b)) $file
done
