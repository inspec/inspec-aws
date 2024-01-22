+++
title = "aws_amplify_apps resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_amplify_apps"
identifier = "inspec/resources/aws/aws_amplify_apps resource"
parent = "inspec/resources/aws"
+++

Use the `aws_amplify_apps` InSpec audit resource to test the properties of Multiple AWS Amplify apps.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Amplify App](https://docs.aws.amazon.com/amplify/latest/APIReference/API_App.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that AWS Amplify app exists.

```ruby
describe aws_amplify_apps  do
  it { should exist }
end
```


## Parameters

This resource does not require any parameters.

## Properties

`app_arns`
: The Amazon Resource Name (ARN) of the Amplify app.

: **Field**: `app_arn`

`app_ids`
: The unique ID of the Amplify app.

: **Field**: `app_id`

`app_arns`
: The app's Amazon Resource app_id (ARN).

: **Field**: `app_arn`

`names`
: The name for the Amplify app.

: **Field**: `name`

`description`
: The description for the Amplify app.

: **Field**: `description`

`repositories`
: The repository for the Amplify app.

: **Field**: `repository`

`platforms`
: The platform for the Amplify app.

: **Field**: `platform`

`create_time`
: Creates a date and time for the Amplify app.

: **Field**: `create_time`

`update_time`
: Updates the date and time for the Amplify app.

: **Field**: `update_time`

`environment_variables`
: The environment variables for the Amplify app.

: **Field**: `environment_variables`

`pending_engine_versions`
: The app engine version to upgrade to.

: **Field**: `pending_engine_version`

`default_domains`
: The default domain for the Amplify app.

: **Field**: `default_domain`

`enable_branch_auto_build`
: Automatically disconnect a branch in the Amplify Console when you delete a branch from your Git repository.

: **Field**: `enable_branch_auto_build`

`enable_basic_auth`
: Enables basic authorization for the Amplify app's branches.

: **Field**: `enable_basic_auth`

## Examples

**Ensure a app ID is available.**

```ruby
describe aws_amplify_apps  do
  its('app_ids') { should include 'app_id' }
end
```

**Ensure a app name is available.**

```ruby
describe aws_amplify_apps  do
    its('app_names') { should include 'app_name' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `List` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_amplify_apps  do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_amplify_apps  do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the Amplify  App is available.

```ruby
describe aws_amplify_apps  do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="Amplify:Client:ListAppsResult" %}}
