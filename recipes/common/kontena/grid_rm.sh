source helpers/common.sh

echo "About to remove grid: $GRID_NAME"
hitEnter

kontena grid rm --force $GRID_NAME
