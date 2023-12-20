+++
title = "aws_amplify_app resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_amplify_app"
identifier = "inspec/resources/aws/aws_amplify_app resource"
parent = "inspec/resources/aws"
+++

Use the `aws_amplify_app` InSpec audit resource to test the properties of a single specific AWS Amplify app.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Amplify  App](https://docs.aws.amazon.com/amplify/latest/APIReference/API_App.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that AWS Amplify App exists.

```ruby
describe aws_amplify_app(app_id: 'APP_ID') do
  it { should exist }
end
```

## Parameters

`app_id` _(required)_

: The unique ID of the Amplify app.

## Properties

`app_arn`
: The Amazon Resource Name (ARN) of the Amplify app.

`app_id`
: The unique ID of the Amplify app.

`app_arn`
: The app's Amazon Resource app_id (ARN).

`name`
: The name for the Amplify app.

`description`
: The description for the Amplify app.

`repository`
: The repository for the Amplify app.

`platform`
: The platform for the Amplify app.

`create_time`
: Creates a date and time for the Amplify app.

`update_time`
: Updates the date and time for the Amplify app.

`environment_variables`
: The environment variables for the Amplify app.

`pending_engine_versions`
: The app engine version to upgrade to.

`default_domain`
: The default domain for the Amplify app.

`enable_branch_auto_build`
: Automatically disconnect a branch in the Amplify Console when you delete a branch from your Git repository.

`enable_basic_auth`
: Enables basic authorization for the Amplify app's branches.

## Examples

**Ensure a app ID is available.**

```ruby
describe aws_amplify_app(app_id: 'APP_ID') do
  its('app_id') { should eq 'APP_ID' }
end
```

**Ensure a app name is available.**

```ruby
describe aws_amplify_app(app_id: 'APP_ID') do
    its('app_name') { should eq 'APP_NAME' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_amplify_app(app_id: 'APP_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_amplify_app(app_id: 'APP_ID') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the Amplify  App is available.

```ruby
describe aws_amplify_app(app_id: 'APP_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="Amplify:Client:GetAppResult" %}}
