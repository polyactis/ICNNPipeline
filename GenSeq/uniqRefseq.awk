#!/usr/bin/awk -f
{
	count[$2]++
	record[$2] = $0
}
END{
	for (id in count) {
		if (count[id] == 1) {
			print record[id]
		}
	}
}
