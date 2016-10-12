VAR_FILE=vars/$1-$2.tfvars

if [ -e "$VAR_FILE" ]; then
  INCLUDE_VAR_FILE="-var-file=$VAR_FILE"
fi

if [ "$KONTERRAFORM_FRONTEND" == "noninteractive" ] && [ "$INCLUDE_VAR_FILE" == "" ]; then
  echo
  echo "ERROR: noninteractive not possible without $VAR_FILE"
  exit 1
fi
