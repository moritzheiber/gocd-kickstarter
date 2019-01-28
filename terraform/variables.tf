provider "gocd" {
  version = "1.0.0"
}

variable "pipeline_group_name" {
  type    = "string"
  default = "pipeline_group"
}

variable "first_pipeline_name" {
  type    = "string"
  default = "first_pipeline"
}

variable "second_pipeline_name" {
  type    = "string"
  default = "second_pipeline"
}

variable "default_timeout" {
  type    = "string"
  default = "10"
}

variable "pipeline_resources" {
  type = "string"
}
