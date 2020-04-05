# MediaCodex Infrastructure

[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=mediacodex_infrastructure&metric=alert_status)](https://sonarcloud.io/dashboard?id=mediacodex_infrastructure)
[![build status](https://gitlab.com/mediacodex/infrastructure/badges/master/pipeline.svg)](https://gitlab.com/mediacodex/infrastructure/pipelines)

Since this is essentially the core of all of the MediaCodex projects, this is the repo that need to be deployed first.

## Remote-state access

Due to the way that Terraform workspaces work all of the remote backend state storage/locking is on the root AWS account. For the deployment users (one per environment)
to be able to access the backend, the root account needs an IAM role to be deployed. Because it is difficult to modify Terraform's backend per workspace, there is currently
only a single role for both `development` and `production` to share.

Since it is impossible to lock down specific dynamo items via IAM there is little to nothing that can be done to secure which environment has access the the various locks.
The actual state, on the other hand, is secured by adding a condition to the IAM policy so that the directories inside S3 can only be access when the IAM use that's assuming
the role comes from the correct account. For example, the development deploy user belongs to the development AWS account, and as such can only access the state files that
reside within the `env:/development/` bucket path.
