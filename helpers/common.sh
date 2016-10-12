set -e

function hitEnter() {
  if [ -z "$KONTERRAFORM_FRONTEND" ]; then
    echo "hit enter to apply, control+c to cancel"
    read
  elif [ "$KONTERRAFORM_FRONTEND" == "noninteractive" ]; then
    echo "KONTERRAFORM_FRONTEND set to noninteractive, applying automatically"
  fi
}
