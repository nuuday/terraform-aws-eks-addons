#! /bin/bash
# the script is executed from the terraform cache directory and the contents of the module are copied here
source .terraform/modules/cloud_watch_synthetics/scripts/env-helper.sh

while getopts n:s:k:t:r: option
do
case "${option}"
in
n) NAME=${OPTARG};;
s) S3_BUCKET=${OPTARG};;
k) S3_KEY=${OPTARG};;
t) TAGS=${OPTARG};;
r) ROLE_ARN=${OPTARG};;
*) echo "usage: $0 [-v] [-r]" >&2
   exit 1 ;;
esac
done

function create_canary() {
  aws synthetics create-canary --name "$NAME" --execution-role-arn "$ROLE_ARN" --artifact-s3-location s3://"$S3_BUCKET" --code S3Bucket="$S3_BUCKET",S3Key="$S3_KEY".zip,Handler=pageLoadBlueprint.handler --runtime-version syn-nodejs-2.2 --schedule Expression="rate(5 minutes)" --tags "$(echo "$TAGS" | sed 's/[{}]//g' | sed 's/:/=/g')"

  echo "Canary created... polling state"

  aws synthetics get-canary --name "$NAME" | jq '.Canary.Status.State'

  while [ "$(aws synthetics get-canary --name "$NAME" | jq '.Canary.Status.State')" != "\"READY\"" ]
  do
    echo "Not ready yet"
    sleep 5s
  done
}

function start_canary() {
  echo "Ready.... starting canary"

  aws synthetics start-canary --name "$NAME"
}

trap teardown_env err EXIT
setup_env

create_canary
start_canary