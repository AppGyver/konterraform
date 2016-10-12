helpers/master_wait $MASTER_URL
ruby helpers/kontena_login.rb $GRID_NAME $MASTER_URL $ADMIN_USERNAME $ADMIN_PASSWORD 10 1

kontena grid create --initial-size=$GRID_INITIAL_SIZE $GRID_NAME

echo "kontena_agent_token=\"$(helpers/extract_grid_token $GRID_NAME)\"" >> vars/aws-$RECIPE_NAME.tfvars
echo "kontena_agent_master_uri=\"$MASTER_URL\"" >> vars/aws-$RECIPE_NAME.tfvars