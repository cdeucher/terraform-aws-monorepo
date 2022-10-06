variable "app_name" {
    type = "string"
}
variable "region" {
    type = "string"
    default = "us-east-1"
}
variable "bucket_name" {
    type = "string"
}
variable "s3_origin_id" {
    type = "string"
}