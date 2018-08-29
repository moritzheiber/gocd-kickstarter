provider "gocd" {
  version = "0.1.23"
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

variable "pipeline_resources" {
  type = "string"
}
