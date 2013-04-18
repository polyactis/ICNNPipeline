cat - | tail -1 | grep -o "Your job [0-9]*" | cut -f3 -d' '
