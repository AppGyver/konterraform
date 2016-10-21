source helpers/common.sh

services=$(kontena service ls | tail -n +2 | cut -f 2 -d " ")
for service in $services; do
  echo "About to remove service $service"
  hitEnter
  echo "sleeping 3 seconds anyway.."

  kontena service stop $service
  kontena service rm --force $service
  echo "removed service $service"
done
