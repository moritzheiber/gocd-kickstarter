# GoCD Kickstarter

A repository which lets you get started with [GoCD](https://www.gocd.org) and its [Terraform provider](https://github.com/beamly/terraform-provider-gocd). You can use Terraform to fully express all of your pipelines as code.

# Setup

Prerequisites:

- Docker (>= 18.06.1-ce)
- docker-compose (>= 1.20.1)
- Terraform (>= 0.11.8)
- curl
- bash

# Run a GoCD server/agent

You can use the `docker-compose.yml` file that is shipped with this kickstarter to provision a new GoCD server and a single agent along with it:

```sh
$ ./run compose
```

This will run the `docker-compose` definitions in the foreground.

_Note: The GoCD server takes a lot of time to get started, sometimes up to 60 seconds. Keep that in mind when provisioning your instance._

# Deploy your pipelines

The `run` script will do the heavy lifting for you:

```sh
$ ./run terraform apply
```
This will use Terraform to provision two simple pipelines, mostly `echo` statements, with a `git` material, some environment variables, and a pipeline dependency. It's not too complicated to grasp in the beginning but also complex enough to suit most initial GoCD deployments.

# TODO

- Windows support (technically, Windows is supported already, it just has never been tested)
