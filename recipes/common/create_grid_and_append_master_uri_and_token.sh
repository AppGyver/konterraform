[ ! $MASTER_URL ] && echo "MASTER_URL missing" && exit 1
[ ! $MASTER_NAME ] && echo "MASTER_NAME missing" && exit 1
[ ! $GRID_INITIAL_SIZE ] && echo "GRID_INITIAL_SIZE missing" && exit 1
[ ! $GRID_NAME ] && echo "GRID_NAME missing" && exit 1

helpers/master_wait $MASTER_URL

source library/support/abort_if_bug_1262.sh

kontena master login \
  --code "$(bin/output aws mega-eu-west-1 kontena_master_initial_admin_code)" \
  --name "$MASTER_NAME" \
  $MASTER_URL

kontena grid create --initial-size=$GRID_INITIAL_SIZE $GRID_NAME

echo "kontena_agent_master_uri=\"$MASTER_URL\"" >> vars/$PROVIDER_NAME-$RECIPE_NAME.tfvars
echo "kontena_agent_token=\"$(helpers/extract_grid_token $GRID_NAME)\"" >> vars/$PROVIDER_NAME-$RECIPE_NAME.tfvars
