#!/bin/bash

# Laravel Boilerplate [LBP] variables
LBP_REPO='fl-laravel_boilerplate'
LBP_API_SERVICE_NAME='laravel-api'
LBP_PG_SERVICE_NAME='laravel-pg'
LBP_TF_SERVICE_NAME='laravel-tf'
LBP_IP_FIRST_TWO_OCTETS='22.95'
LBP_PORT_HTTP='295'
LBP_PORT_VITE='296'
LBP_PORT_DB='297'

# Project variables: Please update these before running the script
PROJECT_REPO=$(git config --get remote.origin.url | sed 's/.*\///' | sed 's/\.git//' | sed 's/[_&$ ]/\-/g')
PROJECT_IP_FIRST_TWO_OCTETS='21.95'
echo "Provide Repo name (If you want to proceed with default, press enter)"
read -e -i "$PROJECT_REPO" -p "Please enter repo name: " input
PROJECT_REPO="${input:-$PROJECT_REPO}"
PROJECT_API_SERVICE_NAME="$PROJECT_REPO"
PROJECT_PG_SERVICE_NAME="$PROJECT_REPO-pg"
PROJECT_TF_SERVICE_NAME="$PROJECT_REPO-tf"
PROJECT_IP_FIRST_TWO_OCTETS='21.95'
echo "Provide first two Octets (If you want to proceed with default, press enter)"
read -e -i "$PROJECT_IP_FIRST_TWO_OCTETS" -p "Please enter first two octet: " input
PROJECT_IP_FIRST_TWO_OCTETS="${input:-$PROJECT_IP_FIRST_TWO_OCTETS}"
PROJECT_PORT_HTTP='190'
PROJECT_PORT_VITE='191'
PROJECT_PORT_DB='192'

# Replace LBP vars with PROJECT vars in files
sed -i -- "s/$LBP_REPO/$PROJECT_REPO/g; \
    s/$LBP_API_SERVICE_NAME/$PROJECT_API_SERVICE_NAME/g; \
    s/$LBP_PG_SERVICE_NAME/$PROJECT_PG_SERVICE_NAME/g; \
    s/$LBP_TF_SERVICE_NAME/$PROJECT_TF_SERVICE_NAME/g; \
    s/$LBP_IP_FIRST_TWO_OCTETS/$PROJECT_IP_FIRST_TWO_OCTETS/g; \
    s/$LBP_PORT_HTTP/$PROJECT_PORT_HTTP/g; \
    s/$LBP_PORT_VITE/$PROJECT_PORT_VITE/g; \
    s/$LBP_PORT_DB/$PROJECT_PORT_DB/g; \
    " \
    ./terraform/apps.tf ../README.md ../docker-compose.yml ../composer.json ../.circleci/config.yml ../.github/workflows/ci.yml ../.env.example ../.env.testing ../vite.config.js

docker-compose up --build -d
docker-compose exec "$PROJECT_API_SERVICE_NAME" composer install
docker-compose exec "$PROJECT_API_SERVICE_NAME" composer run dev-setup


echo "Collecting information to setup Infra"
echo "Provide Heroku Account Email: To find please visit https://dashboard.heroku.com/account"
read -r HEROKU_ACCOUNT_EMAIL

echo "Provide Heroku AUTH Key: To generate one please visit https://dashboard.heroku.com/account/applications#authorizations"
read -r HEROKU_AUTH_KEY

echo "Provide CircleCI token: To generate one please visit https://app.circleci.com/settings/user/tokens"
read -r CIRCLE_TOKEN

echo "Provide POSTMAN API token: To generate one please follow steps mentioned here https://learning.postman.com/docs/developer/intro-api/#generating-a-postman-api-key"
read -r POSTMAN_API_KEY

REPO_NAME=$(git config --get remote.origin.url | sed 's/.*\///' | sed 's/\.git//' | sed 's/[_&$ ]/\-/g')
PIPELINE_NAME="$REPO_NAME"
HEROKU_STAGING_APP="staging-$REPO_NAME"
HEROKU_PRODUCTION_APP="production-$REPO_NAME"

echo "Pipeline name: $PIPELINE_NAME"
echo "Staging app name: $HEROKU_STAGING_APP"
echo "Production app name: $HEROKU_PRODUCTION_APP"

sed -i -e 's/%HEROKU_ACCOUNT_EMAIL%/'"$HEROKU_ACCOUNT_EMAIL"'/g' ./terraform/terraform.tfvars
sed -i -e 's/%HEROKU_API_KEY%/'"$HEROKU_AUTH_KEY"'/g' ./terraform/terraform.tfvars
sed -i -e 's/%HEROKU_PIPELINE_NAME%/'"$PIPELINE_NAME"'/g' ./terraform/terraform.tfvars
sed -i -e 's/%HEROKU_STAGING_APP%/'"$HEROKU_STAGING_APP"'/g' ./terraform/terraform.tfvars
sed -i -e 's/%HEROKU_PRODUCTION_APP%/'"$HEROKU_PRODUCTION_APP"'/g' ./terraform/terraform.tfvars


#REPO_NAME=vtest
sed -i -e 's/%PROJECT_NAME%/'"$REPO_NAME"'/g' ./ci.sh
sed -i -e 's/%HEROKU_AUTH_KEY%/'"$HEROKU_AUTH_KEY"'/g' ./ci.sh
sed -i -e 's/%CIRCLE_TOKEN%/'"$CIRCLE_TOKEN"'/g' ./ci.sh
sed -i -e 's/%HEROKU_STAGING_APP%/'"$HEROKU_STAGING_APP"'/g' ./ci.sh
sed -i -e 's/%POSTMAN_API_KEY%/'"$POSTMAN_API_KEY"'/g' ./ci.sh


sed -i -e 's/%HEROKU_AUTH_KEY%/'"$HEROKU_AUTH_KEY"'/g' ./terraform/heroku.sh
sed -i -e 's/%HEROKU_STAGING_APP%/'"$HEROKU_STAGING_APP"'/g' ./terraform/heroku.sh
sed -i -e 's/%HEROKU_PRODUCTION_APP%/'"$HEROKU_PRODUCTION_APP"'/g' ./terraform/heroku.sh
sed -i -e 's/%PROJECT_TF_SERVICE_NAME%/'"$PROJECT_TF_SERVICE_NAME"'/g' ./terraform/heroku.sh
sed -i -e 's/%PROJECT_API_SERVICE_NAME%/'"$PROJECT_API_SERVICE_NAME"'/g' ./terraform/heroku.sh

docker exec -it "$PROJECT_TF_SERVICE_NAME" terraform init
docker exec -it "$PROJECT_TF_SERVICE_NAME" terraform plan -out=out.json
docker exec -it "$PROJECT_TF_SERVICE_NAME" terraform apply out.json
