resource "gocd_pipeline" "first_pipeline" {
  name           = "${var.first_pipeline_name}"
  group          = "${var.pipeline_group_name}"
  label_template = "$${COUNT}"

  environment_variables = [{
    name  = "SOME_VARIABLE"
    value = "I'm some variable!"
  }]

  materials = [
    {
      type = "git"

      attributes {
        name = "rbenv_git_repository"
        url  = "https://github.com/rbenv/rbenv"

        filter = {
          ignore = [
            "README.md",
            "LICENSE",
            "CONDUCT.md",
          ]
        }
      }
    },
  ]
}

resource "gocd_pipeline_stage" "first_pipeline_stage" {
  name     = "first_stage"
  pipeline = "${gocd_pipeline.first_pipeline.name}"

  clean_working_directory = true
  fetch_materials         = true

  jobs = [
    "${data.gocd_job_definition.first_pipeline_job.json}",
  ]
}

data "gocd_job_definition" "first_pipeline_job" {
  name = "first_job"

  resources = ["${var.pipeline_resources}"]

  timeout = "${var.default_timeout}"

  tasks = [
    "${data.gocd_task_definition.first_pipeline_job_task.json}",
  ]
}

data "gocd_task_definition" "first_pipeline_job_task" {
  type    = "exec"
  command = "/bin/sh"

  arguments = [
    "-c",
    "echo $${SOME_VARIABLE}",
  ]
}
