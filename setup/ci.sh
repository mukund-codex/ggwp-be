#!/bin/bash

REPO_NAME="%PROJECT_NAME%"
HEROKU_STAGING_APP="%HEROKU_STAGING_APP%"
HEROKU_AUTH_KEY="%HEROKU_AUTH_KEY%"
CIRCLE_TOKEN="%CIRCLE_TOKEN%"
POSTMAN_API_KEY="%POSTMAN_API_KEY%"

curl --request POST \
--url https://circleci.com/api/v1.1/project/gh/founderandlightning/"$REPO_NAME"/follow \
--header 'Circle-Token: '"$CIRCLE_TOKEN"''

curl --request POST \
--url https://circleci.com/api/v2/project/gh/founderandlightning/"$REPO_NAME"/envvar \
--header 'Circle-Token: '"$CIRCLE_TOKEN"'' \
--header 'content-type: application/json' \
--data '{"name":"APP_DEBUG","value":"true"}'

curl --request POST \
--url https://circleci.com/api/v2/project/gh/founderandlightning/"$REPO_NAME"/envvar \
--header 'Circle-Token: '"$CIRCLE_TOKEN"'' \
--header 'content-type: application/json' \
--data '{"name":"APP_ENV","value":"testing"}'


curl --request POST \
--url https://circleci.com/api/v2/project/gh/founderandlightning/"$REPO_NAME"/envvar \
--header 'Circle-Token: '"$CIRCLE_TOKEN"'' \
--header 'content-type: application/json' \
--data '{"name":"APP_KEY","value":"true"}'


curl --request POST \
--url https://circleci.com/api/v2/project/gh/founderandlightning/"$REPO_NAME"/envvar \
--header 'Circle-Token: '"$CIRCLE_TOKEN"'' \
--header 'content-type: application/json' \
--data '{"name":"APP_URL","value":"true"}'


curl --request POST \
--url https://circleci.com/api/v2/project/gh/founderandlightning/"$REPO_NAME"/envvar \
--header 'Circle-Token: '"$CIRCLE_TOKEN"'' \
--header 'content-type: application/json' \
--data '{"name":"DATABASE_URL","value":"pgsql://postgres:docker@22.95.1.2:5432/postgres"}'


curl --request POST \
--url https://circleci.com/api/v2/project/gh/founderandlightning/"$REPO_NAME"/envvar \
--header 'Circle-Token: '"$CIRCLE_TOKEN"'' \
--header 'content-type: application/json' \
--data '{"name":"DB_CONNECTION","value":"pgsql"}'


curl --request POST \
--url https://circleci.com/api/v2/project/gh/founderandlightning/"$REPO_NAME"/envvar \
--header 'Circle-Token: '"$CIRCLE_TOKEN"'' \
--header 'content-type: application/json' \
--data '{"name":"QUEUE_CONNECTION","value":"database"}'


curl --request POST \
--url https://circleci.com/api/v2/project/gh/founderandlightning/"$REPO_NAME"/envvar \
--header 'Circle-Token: '"$CIRCLE_TOKEN"'' \
--header 'content-type: application/json' \
--data '{"name":"ROLLBAR_ACCESS_TOKEN","value":"00000"}'


curl --request POST \
--url https://circleci.com/api/v2/project/gh/founderandlightning/"$REPO_NAME"/envvar \
--header 'Circle-Token: '"$CIRCLE_TOKEN"'' \
--header 'content-type: application/json' \
--data '{"name":"HEROKU_UAT_APP_NAME","value":"'"$HEROKU_STAGING_APP"'"}'


curl --request POST \
--url https://circleci.com/api/v2/project/gh/founderandlightning/"$REPO_NAME"/envvar \
--header 'Circle-Token: '"$CIRCLE_TOKEN"'' \
--header 'content-type: application/json' \
--data '{"name":"HEROKU_AUTH_KEY","value":"'"$HEROKU_AUTH_KEY"'"}'

curl --request POST \
--url https://circleci.com/api/v2/project/gh/founderandlightning/"$REPO_NAME"/envvar \
--header 'Circle-Token: '"$CIRCLE_TOKEN"'' \
--header 'content-type: application/json' \
--data '{"name":"POSTMAN_API_KEY","value":"'"$POSTMAN_API_KEY"'"}'

echo "Please setup webhook on circleCI by adding below details on following link"
printf "\n Link: https://app.circleci.com/settings/project/gh/founderandlightning/"$REPO_NAME"/webhooks/add"
printf "\n Details"
printf "\n Webhook name = Reviewee"
printf "\n Receiver URL = https://api.reviewee.it/notification/circle-ci"
printf "\n Check Both Events"
printf "\n Keep Secret token blank"
printf "\n Uncheck Certificate verification"
printf "\n Click on 'Add Webhook' and press any key to continue"
read -r

