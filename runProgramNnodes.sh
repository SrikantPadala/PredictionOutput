NODE=$1
prog=$2
graph=$3
if [ ! -d $NODE ]; then
	mkdir $NODE
fi
cd $NODE
/home/hadoopnew/output/runStatus.sh status.txt &
PID=$!
/home/hadoopnew/output/runJob.sh $NODE $prog $graph
kill -9 $PID
pkill cpu_mem_client_9
cd ..
