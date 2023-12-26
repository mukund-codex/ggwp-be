locals  {
    s3_bucket_name = [
        "${var.bucket_name}-staging",
        "${var.bucket_name}-production",
        "${var.bucket_name}-backup"
    ]
}

provider "aws" {
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
    region = var.aws_region
}

resource "aws_iam_user" "bucket_user" {
    count = length(local.s3_bucket_name)
    name  = "${local.s3_bucket_name[count.index]}-user"
}



resource "aws_iam_access_key" "bucket_user" {
    count = length(local.s3_bucket_name)
    user  = element(aws_iam_user.bucket_user.*.name, count.index)
}

output "AWS_STAGING_ACCESS" {
    value =   aws_iam_access_key.bucket_user[0].id
    sensitive = true
}
output "AWS_STAGING_SECRET" {
    value =   aws_iam_access_key.bucket_user[0].secret
    sensitive = true
}
output "AWS_PRODUCTION_ACCESS" {
    value =   aws_iam_access_key.bucket_user[1].id
    sensitive = true
}
output "AWS_PRODUCTION_SECRET" {
    value =   aws_iam_access_key.bucket_user[1].secret
    sensitive = true
}

output "AWS_BACKUP_ACCESS" {
    value =   aws_iam_access_key.bucket_user[2].id
    sensitive = true
}
output "AWS_BACKUP_SECRET" {
    value =   aws_iam_access_key.bucket_user[2].secret
    sensitive = true
}

resource "aws_iam_user_policy" "bucket_user" {
    count =length(local.s3_bucket_name)
    name = "${local.s3_bucket_name[count.index]}-policy"
    user = element(aws_iam_user.bucket_user.*.name, count.index)
    policy= <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::${local.s3_bucket_name[count.index]}",
                "arn:aws:s3:::${local.s3_bucket_name[count.index]}/*"
            ]
        },
        {
            "Effect": "Deny",
            "NotAction": "s3:*",
            "NotResource": [
                "arn:aws:s3:::${local.s3_bucket_name[count.index]}",
                "arn:aws:s3:::${local.s3_bucket_name[count.index]}/*"
            ]
        }
   ]
}
EOF
}

resource "aws_s3_bucket" "aws_bucket" {
    count         = length(local.s3_bucket_name)
    bucket        = local.s3_bucket_name[count.index]
    force_destroy = "true"
}

output "AWS_STAGING_BUCKET" {
    value =   aws_s3_bucket.aws_bucket[0].id
    sensitive = true
}

output "AWS_PRODUCTION_BUCKET" {
    value =   aws_s3_bucket.aws_bucket[1].id
    sensitive = true
}

output "AWS_BACKUP_BUCKET" {
    value =   aws_s3_bucket.aws_bucket[2].id
    sensitive = true
}

resource "aws_s3_bucket_acl" "aws_bucket_acl" {
    count  = length(local.s3_bucket_name)
    bucket = local.s3_bucket_name[count.index]
    acl    = "private"
}

resource "aws_s3_bucket_cors_configuration" "aws_bucket_cors" {
    count  = length(local.s3_bucket_name)
    bucket = local.s3_bucket_name[count.index]
    cors_rule {
        allowed_headers = ["*"]
        allowed_methods = ["PUT","POST","GET"]
        allowed_origins = ["*"]
        expose_headers  = ["ETag"]
        max_age_seconds = 3000
    }
}


resource "aws_s3_bucket_policy" "aws_bucket_policy" {
    count  = length(local.s3_bucket_name)
    bucket = local.s3_bucket_name[count.index]
    policy = <<EOF
  {
        "Version": "2012-10-17",
        "Statement": [
          {
              "Effect": "Allow",
              "Principal": {
                  "AWS": "${element(aws_iam_user.bucket_user.*.arn, count.index)}"
              },
              "Action": [
                  "s3:GetObject",
                  "s3:PutObject"
              ],
             "Resource": [
                  "arn:aws:s3:::${local.s3_bucket_name[count.index]}",
                  "arn:aws:s3:::${local.s3_bucket_name[count.index]}/*"
              ],
              "Condition": {
                  "StringEquals": {
                      "aws:PrincipalArn": "${element(aws_iam_user.bucket_user.*.arn, count.index)}"
                  }
              }
          }
      ]
  }
  EOF
}
