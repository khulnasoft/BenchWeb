#!/bin/bash

set -e

echo "running bw-shutdown script"
./bw-shutdown.sh

echo "removing old bw directory if necessary"
if [ -d "$BW_REPOPARENT/$BW_REPONAME" ]; then
  sudo rm -rf $BW_REPOPARENT/$BW_REPONAME
fi

echo "cloning bw repository"
git clone \
  -b $BW_REPOBRANCH \
  $BW_REPOURI \
  $BW_REPOPARENT/$BW_REPONAME \
  --depth 1

echo "moving to bw directory"
cd $BW_REPOPARENT/$BW_REPONAME

if [ -z "$BW_RUN_ORDER" ]; then
  export BW_RUN_ORDER="reverse"
else
  unset BW_RUN_ORDER
fi

echo "building bw docker image"
docker build -t khulnasoft/bw \
  --build-arg USER_ID=$(id -u) \
  --build-arg GROUP_ID=$(id -g) .

echo "running bw docker image"
docker run \
  -e USER_ID=$(id -u) \
  --network=host \
  --mount type=bind,source=$BW_REPOPARENT/$BW_REPONAME,target=/BenchWeb \
  khulnasoft/bw \
  --server-host $BW_SERVER_HOST \
  --client-host $BW_CLIENT_HOST \
  --database-host $BW_DATABASE_HOST \
  --network-mode host \
  --results-name "$BW_RUN_NAME" \
  --results-environment "$BW_ENVIRONMENT" \
  --results-upload-uri "$BW_UPLOAD_URI" \
  $(if [ "$BW_RUN_ORDER" = "reverse" ]; then echo "--reverse-order"; fi) \
  --quiet

echo "zipping the results"
zip -r results.zip results

echo "uploading the results"
curl \
  -i -v \
  -X POST \
  --header "Content-Type: application/zip" \
  --data-binary @results.zip \
  $BW_UPLOAD_URI

echo "done uploading results"
