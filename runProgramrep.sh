#bin/bash!
NITER=$1
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
ITER=1
while [ $ITER -le $NITER ]
do
	cd $ITER
	SIZE=$(du -s ~/GraphDatabases/$graph | cut -f 1)
	/home/hadoopnew/output/runProgramNnodes.sh 3 $prog $graph
	(( ITER++ ))
	cd ..
done
