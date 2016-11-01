if [[ $(grep "\"name\": \"${MASTER_NAME}\"" ~/.kontena_client.json) == "" ]]; then
  echo "No master name in ~/.kontena_client.json, this is good"
else
  echo "Master with name ${MASTER_NAME} already exists (bug: https://github.com/kontena/kontena/pull/1238) aborting."
  exit 1
fi
