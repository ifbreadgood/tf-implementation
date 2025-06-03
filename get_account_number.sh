#!/usr/bin/env bash

set -ex

path=$1
account_number=1

if [[ "$path" == */aws/* ]]; then
  account_name=$(echo "$path" | sed -n "s|.*/aws/\([^/]*\).*|\1|p")
  case "$account_name" in
    "identity") echo 925697179472 ;;
    "network-test") echo 661012794237 ;;
    "workload-test") echo 734244935726 ;;
    *) echo "invalid aws account" && exit 1 ;;
  esac
else
  # use shared account
  echo 123
fi
