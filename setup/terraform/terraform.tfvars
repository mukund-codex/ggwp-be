# terraform variables values, update this file with your own values

heroku_region = "eu"
heroku_account_email = "%HEROKU_ACCOUNT_EMAIL%"
heroku_api_key = "%HEROKU_API_KEY%"
heroku_pipeline_name = "%HEROKU_PIPELINE_NAME%"
heroku_staging_app = "%HEROKU_STAGING_APP%"
heroku_production_app = "%HEROKU_PRODUCTION_APP%"

heroku_staging_database = "heroku-postgresql:hobby-basic"
heroku_staging_newrelic = "newrelic:wayne"
heroku_staging_papertrail= "papertrail:choklad"
heroku_staging_rollbar = "rollbar:trial-5k"
heroku_staging_scheduler = "scheduler:standard"
heroku_staging_redis = "heroku-redis:premium-0"

heroku_production_database = "heroku-postgresql:hobby-basic"
heroku_production_newrelic = "newrelic:wayne"
heroku_production_papertrail= "papertrail:choklad"
heroku_production_rollbar = "rollbar:trial-5k"
heroku_production_scheduler = "scheduler:standard"
heroku_production_redis = "heroku-redis:premium-0"

heroku_app_buildpacks = [
  "heroku/nodejs",
  "heroku/php",
  "https://github.com/svikramjeet/db-back-s3",
]
