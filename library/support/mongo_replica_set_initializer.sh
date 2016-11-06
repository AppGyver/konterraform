#!/usr/bin/env sh

MONGO_HOST_PREFIX=$1
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function dockerMongoRun() {
  docker run --rm \
    --link=kontena-server-mongo:mongo \
    mongo:3.0 \
    mongo --host mongo --eval "printjson($1)"
}

echo "Current node: $(hostname)"
echo "Current script directory: $DIR"
echo "MONGO_HOST_PREFIX: $MONGO_HOST_PREFIX"

node_index=$(echo $(hostname) | rev | cut -d "-" -f 1 | rev)
if [ ! "$node_index" == "0" ]; then
  echo "Only running on node 0, skipping this node ($node_index)"
  exit 0
fi

for node_index in $(seq -s ' ' 0 2); do
  while true; do
    CURRENT_MONGO_HOST="${MONGO_HOST_PREFIX}-$node_index"
    ncat $CURRENT_MONGO_HOST 27017 < /dev/null

    if [ "$?" == "0" ]; then
      echo "$CURRENT_MONGO_HOST is up"
      break
    else
      echo "$CURRENT_MONGO_HOST is not yet up, will continue to wait.."
      sleep 1
    fi
  done

  while true; do
    dockerMongoRun "db.stats()"

    if [ "$?" == "0" ]; then
      echo "$CURRENT_MONGO_HOST mongo ok"
      break
    else
      echo "$CURRENT_MONGO_HOST mongo not ok, will continue to wait.."
      sleep 1
    fi
  done
done

dockerMongoRun "rs.initiate({_id: 'kontena-server-rs', version: 1, members: [{ _id: 0, host : '${MONGO_HOST_PREFIX}-0:27017' },{ _id: 1, host : '${MONGO_HOST_PREFIX}-1:27017' },{ _id: 2, host : '${MONGO_HOST_PREFIX}-2:27017' }]})"
sleep 3
dockerMongoRun "rs.status()"
