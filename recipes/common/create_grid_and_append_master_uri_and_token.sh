[ ! $MASTER_URL ] && echo "MASTER_URL missing" && exit 1

helpers/master_wait $MASTER_URL

kontena master login \
  --code konterraforminitialadmincode \
  --name "${GRID_NAME}_master" \
  $MASTER_URL

kontena grid create --initial-size=$GRID_INITIAL_SIZE $GRID_NAME

echo "kontena_agent_master_uri=\"$MASTER_URL\"" >> vars/$PROVIDER_NAME-$RECIPE_NAME.tfvars
echo "kontena_agent_token=\"$(helpers/extract_grid_token $GRID_NAME)\"" >> vars/$PROVIDER_NAME-$RECIPE_NAME.tfvars
