# Heroku Provider variables
variable "heroku_account_email" {}
variable "heroku_api_key" {}

# Pipeline variables
variable "heroku_pipeline_name" {}

# Apps variables
variable "heroku_staging_app" {}
variable "heroku_production_app" {}
variable "heroku_region" {}

variable "heroku_app_buildpacks" {
  type = list(string)
}

# Addons variable staging
variable "heroku_staging_database" {}
variable "heroku_staging_newrelic" {}
variable "heroku_staging_papertrail" {}
variable "heroku_staging_rollbar" {}
variable "heroku_staging_scheduler" {}
variable "heroku_staging_redis" {}

# Addons variable production
variable "heroku_production_database" {}
variable "heroku_production_newrelic" {}
variable "heroku_production_papertrail" {}
variable "heroku_production_rollbar" {}
variable "heroku_production_scheduler" {}
variable "heroku_production_redis" {}

# Addons variable production
variable "aws_access_key" {
    description = "AWS access key"
    type        = string
}

variable "aws_secret_key" {
    description = "AWS secret key."
    type        = string
}

variable "aws_region" {
    description = "The region of the bucket. (Examples are us-east-1, us-west-2, etc.)"
    type        = string
    default     = "eu-west-2"
}

variable "bucket_name" {
    description = "The name of the bucket"
    type        = string
}
