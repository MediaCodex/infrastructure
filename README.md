# MediaCodex Infrastructure

[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=mediacodex_infrastructure&metric=alert_status)](https://sonarcloud.io/dashboard?id=mediacodex_infrastructure)
[![build status](https://gitlab.com/mediacodex/infrastructure/badges/master/pipeline.svg)](https://gitlab.com/mediacodex/infrastructure/pipelines)

Since this is essentially the core of all of the MediaCodex projects, this is the repo that need to be deployed first.

## Terraform Cloud

All of the mediacodex projects that utilise Terraform have their backend state managed by Terraform Cloud, as such they need to have their dpeloyment user keys added both to GitHub Actions
(for uploading application code) AND set on the TF cloud Workspace vars (for infrastructure deployment).

Terraform is connect to GitHub VCS using an oauth provider, since this is extreamly unlikely to ever change, the actual configuration of that connection has be done manually, as such this
codebase expects you to pass in the oAuth client ID via the `github_oauth_client` variable.