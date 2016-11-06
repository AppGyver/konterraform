MASTER_NAME=$1
GRID_NAME=$2
GRID_INITIAL_SIZE=$3

if [ ! $MASTER_NAME ] || [ ! $GRID_NAME ] || [ ! $GRID_INITIAL_SIZE ]; then
  echo "params: master_name grid_name grid_initial_size"
  exit 1
fi

source recipes/common/provider_name.sh
source recipes/common/recipe_name.sh

echo '
     |  /   \   \   |_  __| __|  \   |     \
      -  (   | | \  |   |  _|   | \  |  |_  |
   __|__\ __/__|  __| __|  ___|_|  __|__| __|
'

echo "provider: $PROVIDER_NAME"
echo "recipe: $RECIPE_NAME"
