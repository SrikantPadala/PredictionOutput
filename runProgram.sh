#bin/bash!
NNODES=$1
prog=$3
graph=$4

if [ ! -d $prog ]; then
	mkdir $prog
fi
cd $prog
if [ ! -d $graph ]; then
	mkdir $graph
fi
cd $graph
NODE=$2
while [ $NODE -le $NNODES ]
do
	SIZE=$(du -s ~/GraphDatabases/$graph | cut -f 1)
	#if [ $SIZE -gt 750000 -a $NODE -eq 1 ]; then
	#	NODE=$((NODE + 2))
	#fi 
	/home/hadoopnew/output/runProgramNnodes.sh $NNODES $prog $graph
	#head -$NNODES /home/hadoopnew/machines | while read line; do ssh -n -f $line "sh -c 'nohup pkill cpu_mem > /dev/null 2>&1 &'"; done
	#echo 'Terminating daemons. Now sleeping 20 sec'
	#sleep 20
	(( NNODES -- ))
done
