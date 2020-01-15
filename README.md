# MediaCodex Infrastructure

Since this is essentially the core of all of the MediaCodex projects, this is the repo that need to be deployed first.

## Init Terraform

If the project has never been deployed before then you will need to comment out the backend configuration and
deploy the stack once first so that the TF backend (state bucket and lock table) exist. Once the backend exists
then you should re-enable the backend and set the bucket name, as explained below.

## Environment variables

Set the bucket name for the backend state to use. Due to [limitations in Terraform](https://github.com/hashicorp/terraform/issues/13022),
this need to be [handled specially](https://github.com/hashicorp/terraform/pull/20428#issuecomment-470674564). Below is and example shell
script that you can `source` into your env

```shell
TF_STATE_BUCKET='some-bucket-name'
export TF_CLI_ARGS_init="-backend-config=\"bucket=${TF_STATE_BUCKET}\""
```

| Name                 | Required | Description                                                                                | Default Value |
| -------------------- | -------- | ------------------------------------------------------------------------------------------ | ------------- |
| CLOUDFLARE_API_TOKEN | Yes      | [Cloudflare Authentication](https://www.terraform.io/docs/providers/cloudflare/index.html) |               |
