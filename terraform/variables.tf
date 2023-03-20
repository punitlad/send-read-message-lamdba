variable "account_id" {
  type      = string
  sensitive = true
}

variable "region" {
  type = string
}

variable "default_tags" {
  type = map(string)
}