nodes=$(kontena node ls | tail -n +2 | cut -f 1 -d " ")
for node in $nodes; do
  kontena node rm --force $node
  echo "removed node $node"
done
