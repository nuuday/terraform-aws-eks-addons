#! /bin/bash
# the script is executed from the terraform cache directory and the contents of the module are copied here
source .terraform/modules/cloud_watch_synthetics/scripts/env-helper.sh

while getopts n:s:k: option
do
case "${option}"
in
s) S3_BUCKET=${OPTARG};;
k) S3_KEY=${OPTARG};;
*) echo "usage: $0 [-v] [-r]" >&2
   exit 1 ;;
esac
done

trap teardown_env err exit
setup_env

aws s3 rm "s3://$S3_BUCKET/$S3_KEY.zip"