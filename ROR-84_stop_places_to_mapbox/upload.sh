#!/bin/bash

file="eksempel.geojson"
uploadName="eksempel-geojson"
accessToken=$TOKEN
user=$USER
tileset="$user.automated-uploaded-tileset"

echo "get credentials"
curl -XPOST "https://api.mapbox.com/uploads/v1/${user}/credentials?access_token=${accessToken}"  > credentials
echo "got credentials: "`cat credentials`

bucket=`cat credentials | jq -r ".bucket"`
key=`cat credentials | jq -r ".key"`
accessKeyId=`cat credentials | jq -r ".accessKeyId"`
secretAccessKey=`cat credentials | jq -r ".secretAccessKey"`
sessionToken=`cat credentials | jq -r ".sessionToken"`
awsurl=`cat credentials | jq -r ".url"`

export AWS_ACCESS_KEY_ID=$accessKeyId
export AWS_SECRET_ACCESS_KEY=$secretAccessKey
export AWS_SESSION_TOKEN=$sessionToken
export AWS_DEFAULT_REGION=us-east-1

echo "upload s3"
aws s3 cp $file s3://$bucket/$key
echo "uploaded to s3"

echo "initiate upload"
curl -X POST -d "{\"tileset\": \"$tileset\", \"url\":\"$awsurl\", \"name\":\"$uploadName\"}" -H "Content-Type:application/json" "https://api.mapbox.com/uploads/v1/${user}?access_token=${accessToken}" > upload.json

echo "upload initiated"

uploadId=`cat upload.json | jq -r ".id"`
echo "upload ID: $uploadId"

sleep 1

statusUrl="https://api.mapbox.com/uploads/v1/${user}/${uploadId}?access_token=${accessToken}"
echo "checking status on: $statusUrl"

curl $statusUrl | jq
