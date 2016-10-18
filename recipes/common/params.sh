GRID_NAME=$1
GRID_INITIAL_SIZE=$2
ADMIN_USERNAME=$3
ADMIN_PASSWORD=$4

if [ ! $GRID_NAME ] || [ ! $GRID_INITIAL_SIZE ] || [ ! $ADMIN_USERNAME ] || [ ! $ADMIN_PASSWORD ]; then
  echo "params: grid_name grid_initial_size admin_email admin_password"
  exit 1
fi

source recipes/common/recipe_name.sh

echo '
     |  /   \   \   |_  __| __|  \   |     \
      -  (   | | \  |   |  _|   | \  |  |_  |
   __|__\ __/__|  __| __|  ___|_|  __|__| __|
'

echo "recipe: $RECIPE_NAME"
