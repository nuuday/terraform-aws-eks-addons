#! /bin/bash
# the script is executed from the terraform cache directory and the contents of the module are copied here
source .terraform/modules/cloud_watch_synthetics/scripts/env-helper.sh

while getopts n:s:k:t: option
do
case "${option}"
in
n) NAME=${OPTARG};;
s) S3_BUCKET=${OPTARG};;
k) S3_KEY=${OPTARG};;
t) TAGS=${OPTARG};;
*) echo "usage: $0 [-v] [-r]" >&2
   exit 1 ;;
esac
done

function clean_up () {
  rm -fr /tmp/cloud-watch-synthetics.$TMP_SUFFIX
  teardown_env
}

function create_node_blueprint() {
  read -r -d '' CODE_SNIPPET <<EOT
var synthetics = require('Synthetics');
const log = require('SyntheticsLogger');

const pageLoadBlueprint = async function () {
    const URL = "http://ingress.$NAME.managed-eks.aws.nuuday.nu/healthz";

    const takeScreenshot = false;

    let page = await synthetics.getPage();

    const response = await page.goto(URL, {waitUntil: 'domcontentloaded', timeout: 30000});
    if (!response) {
        throw "Failed to load page!";
    }

    await page.waitFor(15000);

    if (takeScreenshot) {
        await synthetics.takeScreenshot('loaded', 'loaded');
    }
    let pageTitle = await page.title();
    log.info('Page title: ' + pageTitle);

    if (response.status() < 200 || response.status() > 299) {
        throw "Failed to load page!";
    }
};

exports.handler = async () => {
    return await pageLoadBlueprint();
};
EOT

  TMP_SUFFIX=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 6)
  TMP_DIR="/tmp/cloud-watch-synthetics.$TMP_SUFFIX/nodejs/node_modules"

  mkdir -p $TMP_DIR

  cd /tmp/cloud-watch-synthetics.$TMP_SUFFIX/

  echo $CODE_SNIPPET > nodejs/node_modules/pageLoadBlueprint.js

  zip -r cloud-watch-synthetics.$TMP_SUFFIX.zip *
}

function upload_blueprint_to_s3() {
  aws s3api put-object --bucket $S3_BUCKET --key $S3_KEY.zip --body /tmp/cloud-watch-synthetics.$TMP_SUFFIX/cloud-watch-synthetics.$TMP_SUFFIX.zip --tagging  $(echo $TAGS | sed 's/[{}]//g' | sed 's/:/=/g')

  while [ echo $(aws s3api head-object --bucket $S3_BUCKET --key $S3_KEY.zip --output json --query 'ETag') != "\(404\).+?Not Found" ]
  do
    echo "S3 object not ready yet"
    sleep 5s
  done

  echo "S3 object is ready to read"
}

trap clean_up err EXIT
setup_env

create_node_blueprint
upload_blueprint_to_s3
