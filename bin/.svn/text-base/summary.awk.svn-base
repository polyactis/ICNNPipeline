#!/usr/bin/awk -f
{ len=$1; sum+=len; M=M<len?len:M; m = (length(m)==0||m>len)?len:m}END{print sum/NR "\t" m "\t" M}
