# Heroku apps
provider "heroku" {
  email   = var.heroku_account_email
  api_key = var.heroku_api_key
}

resource "heroku_app" "staging" {
  name   = var.heroku_staging_app
  region = var.heroku_region

  #set config variables
  config_vars = {
    APP_NAME = "fl-laravel_boilerplate-staging"
    APP_DEBUG = "true"
    APP_ENV = "staging"
    APP_KEY = "base64:toWtngjs4ZJCm804J9y+X5sNJ9QZIgHZF5C/LM8lBrk="
    DB_CONNECTION = "pgsql"
    QUEUE_CONNECTION = "database"
    CACHE_DRIVER = "file"
    GITHUB_USERNAME = "founderandlightning"
    GITHUB_REPONAME = "fl-laravel_boilerplate"
    AWS_ACCESS_KEY_ID = "XXX"
    AWS_SECRET_ACCESS_KEY =  "YYY"
    AWS_DEFAULT_REGION = "eu-west-2"
    S3_BUCKET_PATH = "backup"
  }

  buildpacks = var.heroku_app_buildpacks
}

resource "heroku_app" "production" {
  name   = var.heroku_production_app
  region = var.heroku_region

  #set config variables
  config_vars = {
    APP_NAME = "fl-laravel_boilerplate-production"
    APP_DEBUG = "false"
    APP_ENV = "production"
    APP_KEY = "base64:toWtngjs4ZJCm804J9y+X5sNJ9QZIgHZF5C/LM8lBrk="
    QUEUE_CONNECTION = "database"
    CACHE_DRIVER = "file"
    GITHUB_USERNAME = "founderandlightning"
    GITHUB_REPONAME = "fl-laravel_boilerplate"
    AWS_ACCESS_KEY_ID = "XXX"
    AWS_SECRET_ACCESS_KEY =  "YYY"
    AWS_DEFAULT_REGION = "eu-west-2"
    S3_BUCKET_PATH = "backup"
  }

  buildpacks = var.heroku_app_buildpacks
}
