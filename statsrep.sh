ALGO=$1
GRAPH=$2
NODE=$3
i=1
while [ i -le 10 ]
do
PEAK_MEM_USED=$(echo "100.0 - $(column ./$ALGO/$GRAPH/$NODE/$i/status.txt| egrep '10.6.9.205|10.6.9.207|10.6.9.209'| tr -s " " | cut -d ' ' -f 6 | sort -n | head -1)" | bc)
PEAK_CPU_USED=$(echo "100.0 - $(column ./$ALGO/$GRAPH/$NODE/$i/status.txt| egrep '10.6.9.205|10.6.9.207|10.6.9.209'| tr -s " " | cut -d ' ' -f 4 | sort -n | head -1)" | bc)
AVG_MEM_USED=$(echo "100.0 -$(column ./$ALGO/$GRAPH/$NODE/$i/status.txt| egrep '10.6.9.205|10.6.9.207|10.6.9.209' | tr -s " " | cut -d ' ' -f 6 | awk '{ sum += $1; n++ } END { if (n > 0) print sum / n; }')" | bc)
AVG_CPU_USED=$(echo "100.0 -$(column ./$ALGO/$GRAPH/$NODE/$i/status.txt| egrep '10.6.9.205|10.6.9.207|10.6.9.209' | tr -s " " | cut -d ' ' -f 4 | awk '{ sum += $1; n++ } END { if (n > 0) print sum / n; }')" | bc)
TOT_NETWORK=$(echo "100.0 -$(column ./$ALGO/$GRAPH/$NODE/$i/status.txt| egrep '10.6.9.205|10.6.9.207|10.6.9.209' | tr -s " " | cut -d ' ' -f 20 | awk '{ sum += $1; n++ } END { if (n > 0) print sum; }')" | bc)
PER_SEC_NETWORK=$(echo "100.0 -$(column ./$ALGO/$GRAPH/$NODE/$i/status.txt| egrep '10.6.9.205|10.6.9.207|10.6.9.209' | tr -s " " | cut -d ' ' -f 20 | awk '{ sum += $1; n++ } END { if (n > 0) print sum / n; }')" | bc)
echo -n $PEAK_CPU_USED $PEAK_MEM_USED $AVG_CPU_USED $AVG_MEM_USED $TOT_NETWORK $PER_SEC_NETWORK
echo ""
((i++))
done
