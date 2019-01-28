resource "gocd_pipeline" "second_pipeline" {
  name           = "${var.second_pipeline_name}"
  group          = "${var.pipeline_group_name}"
  label_template = "$${first_pipeline_dependency}"

  environment_variables = [{
    name  = "SOME_OTHER_VARIABLE"
    value = "I'm some other variable!"
  }]

  stages = [
    "${data.gocd_stage_definition.second_pipeline_stage.json}",
  ]

  materials = [
    {
      type = "dependency"

      attributes {
        name     = "first_pipeline_dependency"
        pipeline = "${gocd_pipeline.first_pipeline.name}"
        stage    = "${data.gocd_stage_definition.first_pipeline_stage.name}"
      }
    },
  ]
}

data "gocd_stage_definition" "second_pipeline_stage" {
  name = "second_stage"

  clean_working_directory = true
  fetch_materials         = true

  jobs = [
    "${data.gocd_job_definition.second_pipeline_job.json}",
  ]
}

data "gocd_job_definition" "second_pipeline_job" {
  name = "second_job"

  resources = ["${var.pipeline_resources}"]
  timeout   = "${var.default_timeout}"

  tasks = [
    "${data.gocd_task_definition.second_pipeline_first_task.json}",
    "${data.gocd_task_definition.second_pipeline_second_task.json}",
  ]
}

data "gocd_task_definition" "second_pipeline_first_task" {
  type    = "exec"
  command = "/bin/sh"

  arguments = [
    "-c",
    "echo $${SOME_OTHER_VARIABLE}",
  ]
}

data "gocd_task_definition" "second_pipeline_second_task" {
  type    = "exec"
  command = "/bin/sh"

  arguments = [
    "-c",
    "echo \"My dependency has the label $${GO_DEPENDENCY_LABEL_${upper(gocd_pipeline.first_pipeline.name)}_DEPENDENCY}\"",
  ]
}
