#!/bin/bash

HEROKU_STAGING_APP="%HEROKU_STAGING_APP%"
HEROKU_PRODUCTION_APP="%HEROKU_PRODUCTION_APP%"
HEROKU_AUTH_KEY="%HEROKU_AUTH_KEY%"
PROJECT_TF_SERVICE_NAME="%PROJECT_TF_SERVICE_NAME%"
PROJECT_API_SERVICE_NAME="%PROJECT_API_SERVICE_NAME%"

AWS_BACKUP_ACCESS=$(docker exec -it "$PROJECT_TF_SERVICE_NAME" terraform output AWS_BACKUP_ACCESS)
AWS_BACKUP_SECRET=$(docker exec -it "$PROJECT_TF_SERVICE_NAME" terraform output AWS_BACKUP_SECRET)
AWS_PRODUCTION_ACCESS=$(docker exec -it "$PROJECT_TF_SERVICE_NAME" terraform output AWS_PRODUCTION_ACCESS)
AWS_PRODUCTION_SECRET=$(docker exec -it "$PROJECT_TF_SERVICE_NAME" terraform output AWS_PRODUCTION_SECRET)
AWS_STAGING_ACCESS=$(docker exec -it "$PROJECT_TF_SERVICE_NAME" terraform output AWS_STAGING_ACCESS)
AWS_STAGING_SECRET=$(docker exec -it "$PROJECT_TF_SERVICE_NAME" terraform output AWS_STAGING_SECRET)
AWS_BACKUP_BUCKET=$(docker exec -it "$PROJECT_TF_SERVICE_NAME" terraform output AWS_BACKUP_BUCKET)
AWS_STAGING_BUCKET=$(docker exec -it "$PROJECT_TF_SERVICE_NAME" terraform output AWS_STAGING_BUCKET)
AWS_PRODUCTION_BUCKET=$(docker exec -it "$PROJECT_TF_SERVICE_NAME" terraform output AWS_PRODUCTION_BUCKET)
HEROKU_STAGING_APP_KEY=$(docker exec -it "$PROJECT_API_SERVICE_NAME" php artisan key:generate --show --no-ansi)
HEROKU_PRODUCTION_APP_KEY=$(docker exec -it "$PROJECT_API_SERVICE_NAME" php artisan key:generate --show --no-ansi)

HEROKU_STAGING_APP_KEY=$(echo "$HEROKU_STAGING_APP_KEY" | tr -d '\r')
HEROKU_PRODUCTION_APP_KEY=$(echo "$HEROKU_PRODUCTION_APP_KEY" | tr -d '\r')
AWS_STAGING_BUCKET_URI=`echo "$AWS_STAGING_BUCKET" | tr -d '"'`
AWS_PRODUCTION_BUCKET_URI=`echo "$AWS_PRODUCTION_BUCKET" | tr -d '"'`
AWS_STAGING_BUCKET_URL="https://$AWS_STAGING_BUCKET_URI.s3.eu-west-2.amazonaws.com/"
AWS_PRODUCTION_BUCKET_URL="https://$AWS_PRODUCTION_BUCKET_URI.s3.eu-west-2.amazonaws.com/"


curl --request PATCH https://api.heroku.com/apps/$HEROKU_STAGING_APP/config-vars \
--header 'Content-Type: application/json' \
--header 'Accept: application/vnd.heroku+json; version=3' \
--header 'Authorization: Bearer '$HEROKU_AUTH_KEY \
--data-raw '{
    "AWS_SECRET_ACCESS_KEY":'$AWS_BACKUP_SECRET',
    "AWS_ACCESS_KEY_ID":'$AWS_BACKUP_ACCESS',
    "AWS_BUCKET":'$AWS_BACKUP_BUCKET',
    "S3_BUCKET_PATH":'$AWS_BACKUP_BUCKET',
    "AWS_DEFAULT_REGION":"eu-west-2",
    "AWS_BUCKET_URL":'\"${AWS_STAGING_BUCKET_URL}\"',
    "AWS_SECRET":'$AWS_STAGING_SECRET',
    "AWS_KEY":'$AWS_STAGING_ACCESS',
    "AWS_BUCKET_S3":'$AWS_STAGING_BUCKET',
    "AWS_REGION":"eu-west-2",
    "AWS_S3_FILE_ACCESS_AS":"attachment",
    "AWS_S3_URL_EXPIRY_TIME":"10",
    "APP_KEY":'\"${HEROKU_STAGING_APP_KEY}\"'
}'


curl --request PATCH https://api.heroku.com/apps/$HEROKU_PRODUCTION_APP/config-vars \
--header 'Content-Type: application/json' \
--header 'Accept: application/vnd.heroku+json; version=3' \
--header 'Authorization: Bearer '$HEROKU_AUTH_KEY \
--data-raw '{
    "AWS_SECRET_ACCESS_KEY":'$AWS_BACKUP_SECRET',
    "AWS_ACCESS_KEY_ID":'$AWS_BACKUP_ACCESS',
    "AWS_BUCKET":'$AWS_BACKUP_BUCKET',
    "S3_BUCKET_PATH":'$AWS_BACKUP_BUCKET',
    "AWS_DEFAULT_REGION":"eu-west-2",
    "AWS_BUCKET_URL":'\"${AWS_PRODUCTION_BUCKET_URL}\"',
    "AWS_SECRET":'$AWS_PRODUCTION_SECRET',
    "AWS_KEY":'$AWS_PRODUCTION_ACCESS',
    "AWS_BUCKET_S3":'$AWS_PRODUCTION_BUCKET',
    "AWS_REGION":"eu-west-2",
    "AWS_S3_FILE_ACCESS_AS":"attachment",
    "AWS_S3_URL_EXPIRY_TIME":"10",
    "APP_KEY":'\"${HEROKU_PRODUCTION_APP_KEY}\"'
}'
