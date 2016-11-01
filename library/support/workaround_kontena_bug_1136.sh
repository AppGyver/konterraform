#!/usr/bin/env sh
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Current node: $(hostname)"
echo "Current script directory: $DIR"

node_index=$(echo $(hostname) | rev | cut -d "-" -f 1 | rev)
if [ ! "$node_index" == "0" ]; then
  echo "Only running on node 0, skipping this node ($node_index)"
  exit 0
fi

while true; do
  agent_running=$(docker ps -q -f name=kontena-agent)

  if [ "$agent_running" == "" ]; then
    echo "Waiting for agent to start running.."
  else
    echo "Agent running, restarting it in 10s"
    sleep 10
    break
  fi

  sleep 5
done

docker restart kontena-agent

echo "restarted, sleeping 10s before pinging"

sleep 10

echo "pinging 10.81.0.1-5:"

hosts="
1
2
3
4
5
"
for host in $hosts; do
  output=$(ping -c 1 10.81.0.$host | grep "bytes from")
  printf "10.81.0.$host did "
  if [ "$output" == "" ]; then
    echo "NOT pong, maybe you only have 1 or 3 initial nodes?"
  else
    echo "pong!"
  fi
done
