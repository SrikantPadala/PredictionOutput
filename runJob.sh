if [ $2 = "kmeans" ] 
then
	time mpiexec -n $1 --hostfile ~/machines /home/hadoopnew/PowerGraph-master/release/toolkits/clustering/$2 --data /home/hadoopnew/GraphDatabases/$3/ --graph_opts="ingress=random" --clusters 10 > log.txt 2> log.txt
else
	time mpiexec -n $1 --hostfile ~/machines /home/hadoopnew/PowerGraph-master/release/toolkits/graph_analytics/$2 --graph /home/hadoopnew/GraphDatabases/$3/  --format="tsv" --graph_opts="ingress=random"  > log.txt 2> log.txt
fi
