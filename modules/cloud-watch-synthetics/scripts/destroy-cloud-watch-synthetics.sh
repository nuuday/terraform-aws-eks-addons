#! /bin/bash
# the script is executed from the terraform cache directory and the contents of the module are copied here
source .terraform/modules/cloud_watch_synthetics/scripts/env-helper.sh

while getopts n:s: option
do
case "${option}"
in
n) NAME=${OPTARG};;
s) S3_BUCKET=${OPTARG};;
*) echo "usage: $0 [-v] [-r]" >&2
   exit 1 ;;
esac
done

function stop_canary() {
  aws synthetics stop-canary --name "$NAME"

  echo "Canary stopping... polling state"

  while [ "$(aws synthetics get-canary --name "$NAME" | jq '.Canary.Status.State')" != "\"STOPPED\"" ]
  do
    echo "Not stopped yet"
    sleep 5s
  done
}

function delete_canary() {
  echo "Stopped.... deleting canary"

  aws synthetics delete-canary --name "$NAME"

  aws s3 rm "s3://$S3_BUCKET/canary/$NAME/" --recursive
}

trap teardown_env err exit
setup_env

stop_canary
delete_canary