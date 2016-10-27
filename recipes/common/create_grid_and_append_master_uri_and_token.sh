[ ! $MASTER_URL ] && echo "MASTER_URL missing" && exit 1

helpers/master_wait $MASTER_URL
ruby helpers/kontena_login.rb ${GRID_NAME}_master $MASTER_URL $ADMIN_USERNAME $ADMIN_PASSWORD 10 1

kontena grid create --initial-size=$GRID_INITIAL_SIZE $GRID_NAME

echo "kontena_agent_master_uri=\"$MASTER_URL\"" >> vars/$PROVIDER_NAME-$RECIPE_NAME.tfvars
echo "kontena_agent_token=\"$(helpers/extract_grid_token $GRID_NAME)\"" >> vars/$PROVIDER_NAME-$RECIPE_NAME.tfvars
