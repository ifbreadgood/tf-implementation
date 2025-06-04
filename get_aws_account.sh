#!/usr/bin/env bash

set -ex

path=$1
platform=$(echo "$path" | awk -F/ '{print $3}')
environment=$(echo "$path" | awk -F/ '{print $4}')
location=$(echo "$path" | awk -F/ '{print $5}')

if [[ "$platform" == "aws" ]]; then
  case "$environment" in
    "identity") echo account=925697179472 ;;
    "network-test") echo account=661012794237 ;;
    "workload-test") echo account=734244935726 ;;
    "shared") echo account=883385860501 ;;
    "management") echo account=790387652718 ;;
    *) echo "invalid aws account" && exit 1 ;;
  esac
else
  # use shared account
  echo account=883385860501
fi

case "$location" in
  "global") echo region="us-east-2" ;;
  *) echo region="$location" ;;
esac