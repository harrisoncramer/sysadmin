nodeRows=$(ps -aux | grep node | awk {'print $3,$4'});
nodeMem=0;
nodeCpu=0;
count=0;

for row in $nodeRows;
do
  if [ $count -eq 0 ]; then
    nodeMem=$(echo "$nodeMem + $row" | bc);
    count=$(expr $count + 1)
  else
    nodeCpu=$(echo "$nodeCpu + $row" | bc);
    count=0;
  fi
done;

rows=$(ps -aux | grep node -v | awk 'NR>1 {print $3,$4'});
mem=0;
cpu=0;
count=0;
for row in $rows;
do
  if [ $count -eq 0 ]; then
    mem=$(echo "$mem + $row" | bc);
    count=$(expr $count + 1)
  else
    cpu=$(echo "$cpu + $row" | bc);
    count=0;
  fi
done;

totalRows=$(ps -aux);
numProcesses=$(echo "$totalRows" | wc -l);
numNodeProcesses=$(echo "$totalRows" | grep node | wc -l);
numNonNodeProcesses=$(echo "$numProcesses - $numNodeProcesses" | bc);
totalCpu=$(echo "$nodeCpu + $cpu" | bc);
totalMem=$(echo "$nodeMem + $mem" | bc);

echo "{ totalCpu: $totalCpu, totalMem: $totalMem, numProcesses: $numProcesses, numNonNodeProcesses: $numNonNodeProcesses, numNodeProcesses: $numNodeProcesses, nodeMemory: $nodeMem, nodeCpu: $nodeCpu, nonNodeMemory: $mem, nonNodeCpu: $cpu}";