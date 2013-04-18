#!/usr/bin/awk -f
BEGIN {
	srand(systime());
    if (block == 0)  block=100
}
{
   if ( !int(rand()*block) )  print
}
