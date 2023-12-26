# Addons

# staging Addons
resource "heroku_addon" "database-staging" {
  app_id  = heroku_app.staging.id
  plan = var.heroku_staging_database
}
resource "heroku_addon" "newrelic-staging" {
  app_id  = heroku_app.staging.id
  plan = var.heroku_staging_newrelic
}
resource "heroku_addon" "papertrail-staging" {
  app_id  = heroku_app.staging.id
  plan = var.heroku_staging_papertrail
}
resource "heroku_addon" "rollbar-staging" {
  app_id  = heroku_app.staging.id
  plan = var.heroku_staging_rollbar
}

resource "heroku_addon" "redis-staging" {
    app_id  = heroku_app.staging.id
    plan  = var.heroku_staging_redis
}



# Production Addons
resource "heroku_addon" "database-production" {
  app_id  = heroku_app.production.id
  plan = var.heroku_production_database
}
resource "heroku_addon" "newrelic-production" {
  app_id  = heroku_app.production.id
  plan = var.heroku_production_newrelic
}
resource "heroku_addon" "papertrail-production" {
  app_id  = heroku_app.production.id
  plan = var.heroku_production_papertrail
}
resource "heroku_addon" "rollbar-production" {
  app_id  = heroku_app.production.id
  plan = var.heroku_production_rollbar
}

resource "heroku_addon" "redis-production" {
    app_id  = heroku_app.production.id
    plan  = var.heroku_production_redis
}
