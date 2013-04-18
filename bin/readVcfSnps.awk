#!/bin/awk -f
$1!~/^#/ && length($5)==1 && $8 !~/^INDEL/{ print }
