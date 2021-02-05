#! /bin/bash

function setup_env() {
  echo "Setting up env with assumed role"
  STS_OUTPUT=$(aws sts assume-role --role-arn "arn:aws:iam::823203097047:role/admin" --role-session-name cli-session)

  AWS_ACCESS_KEY_ID=$(echo "$STS_OUTPUT" | jq '.Credentials.AccessKeyId' | sed 's/"//g')
  AWS_SECRET_ACCESS_KEY=$(echo "$STS_OUTPUT" | jq '.Credentials.SecretAccessKey' | sed 's/"//g')
  AWS_SESSION_TOKEN=$(echo "$STS_OUTPUT" | jq '.Credentials.SessionToken' | sed 's/"//g')

  export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
  export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
  export AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN
  echo "Env configured with assumed role"
}

function teardown_env() {
  echo "Removing assumed role from env"
  unset AWS_ACCESS_KEY_ID
  unset AWS_SECRET_ACCESS_KEY
  unset AWS_SESSION_TOKEN
  echo "Assumed role removed from env"
}