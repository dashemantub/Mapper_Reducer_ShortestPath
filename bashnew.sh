start-hadoop.sh

hdfs dfs -mkdir input


for i in 1 2 3 4 5 6
do
hdfs dfs -copyFromLocal $HOME/books input/books

hadoop jar $HOME/hadoop/share/hadoop/tools/lib/hadoop-streaming-2.6.4.jar \
-file $HOME/sp_mapper.py -mapper $HOME/sp_mapper.py \
-file $HOME/sp_reducer.py -reducer $HOME/sp_reducer.py \
-input input/books/* -output output/shortestpath

hdfs dfs -cat output/shortestpath/*

rm -r $HOME/books

[ -d "$HOME/books" ] && echo "Directory $HOME/books exists."

hdfs dfs -rm -r input/books

hdfs dfs -copyToLocal output/ $HOME/books

done