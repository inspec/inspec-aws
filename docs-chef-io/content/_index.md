+++
title = "About the Chef InSpec Amazon Web Services (AWS) resource pack"
draft = false

linkTitle = "AWS resource pack"
summary = "Chef InSpec resources for auditing AWS infrastructure."

[cascade]
  [cascade.params]
    platform = "aws"

[menu.aws]
  title = "About AWS resources"
  identifier = "inspec/resources/aws/About"
  parent = "inspec/resources/aws"
  weight = 10
+++

Chef InSpec provides resources for auditing Amazon Web Services (AWS) infrastructure, helping you check security, compliance, and configuration across your cloud environment.

## Create a Chef InSpec profile for AWS auditing

To audit AWS resources, use Chef InSpec 4 or later to create a new profile with `inspec init profile`:

```bash
inspec init profile --platform aws <PROFILE_NAME>
```

After adding your AWS project ID to the `inputs.yml` file, run this sample profile:

```bash
inspec exec <PROFILE_NAME> --input-file=<PROFILE_NAME>/inputs.yml -t aws://
```

## Set AWS credentials

Chef InSpec uses standard AWS authentication mechanisms.
Follow these steps to create an IAM user specifically for auditing activities:

1. In the AWS console, create an IAM user with your choice of username and select **Programmatic Access**.

1. On the **Permissions** screen, select **Attach policies directly** and choose the AWS-managed **ReadOnlyAccess** policy. To restrict the user further, review individual Chef InSpec resources to identify which permissions each resource requires.

1. After generating the key, record the access key ID and secret key.

### Provide credentials using environment variables

Set the following environment variables to provide credentials to Chef InSpec:

- `AWS_REGION`
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`.

You can also use `AWS_PROFILE`, or `AWS_SESSION_TOKEN` if you use  multi-factor authentication.

For more details, see the [AWS Command Line Interface Docs](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html).

After setting your environment variables, verify your credentials:

```bash
$ inspec detect -t aws://

== Platform Details
Name:      aws
Families:  cloud, api
Release:   aws-sdk-v2.10.125
```

### Provide credentials using the Chef InSpec target option

In the `~/.aws/credentials` file in your home directory, add your credentials as a new profile in INI format:

```ini
[<PROFILE_NAME>]
aws_access_key_id = AKIA....
aws_secret_access_key = 1234....abcd
```

Replace `<PROFILE_NAME>` with name defined in your profile's `inspec.yml` file.

### Verify AWS credentials

To verify your credentials, run:

```bash
$ inspec detect -t aws://

== Platform Details
Name:      aws
Families:  cloud, api
Release:   aws-sdk-v2.10.125
```

## Run the profile

Run Chef InSpec using the `--target` / `-t` option in the following format:

```sh
inspec exec <PROFILE_NAME> --input-file=<PROFILE_NAME>/inputs.yml -t aws://<AWS_REGION>/<PROFILE_NAME>
```

For example, to connect to the Ohio region using a profile named 'auditing', use `-t aws://us-east-2/auditing`.

## Chef InSpec AWS resources

{{< inspec_resources_filter >}}

This resource pack includes the following Chef InSpec AWS resources:

{{< inspec_resources section="aws" platform="aws" >}}
