+++
title = "aws_amplify_branch resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_amplify_branch"
identifier = "inspec/resources/aws/aws_amplify_branch resource"
parent = "inspec/resources/aws"
+++

Use the `aws_amplify_branch` InSpec audit resource to test the properties of a single specific AWS Amplify Branch.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Amplify Branch](https://docs.aws.amazon.com/amplify/latest/APIReference/API_App.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that AWS Amplify Branch exists.

```ruby
describe aws_amplify_branch(app_id: 'APP_ID', branch_name: 'BRANCH_NAME') do
  it { should exist }
end
```

## Parameters

`app_id` _(required)_

: The unique ID for an Amplify app.

`branch_name` _(required)_

: The name for the branch that is part of an Amplify app.

## Properties

`branch_arn`
: The Amazon Resource Name (ARN) for a branch that is part of an Amplify app.

`branch_name`
: The name for the branch that is part of an Amplify app.

`description`
: The description for the branch that is part of an Amplify app.

`tags`
: The tag for the branch of an Amplify app.

`stage`
: The current stage for the branch that is part of an Amplify app.

`display_name`
: The display_name for the Amplify Branch.

`platform`
: The platform for the Amplify Branch.

`create_time`
: Creates a date and time for the Amplify Branch.

`update_time`
: Updates the date and time for the Amplify Branch.

`environment_variables`
: The environment variables for the Amplify Branch.

`enable_pull_request_preview`
: The app engine version to upgrade to.

`custom_domain`
: The custom domain for the Amplify Branch.

`pull_request_environment_name`
: Automatically disconnect a branch in the Amplify Console when you delete a branch from your Git repository.

`enable_basic_auth`
: Enables basic authorization for the Amplify Branch's branches.

## Examples

**Ensure a branch arn is available.**

```ruby
describe aws_amplify_branch(app_id: 'APP_ID', branch_name: 'BRANCH_NAME') do
  its('branch_arn') { should eq 'BRANCH_ARN' }
end
```

**Ensure a branch name is available..**

```ruby
describe aws_amplify_branch(app_id: 'APP_ID', branch_name: 'BRANCH_NAME') do
    its('branch_name') { should eq 'BRANCH_NAME' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_amplify_branch(app_id: 'APP_ID', branch_name: 'BRANCH_NAME') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_amplify_branch(app_id: 'APP_ID', branch_name: 'BRANCH_NAME') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the Amplify Branch is available.

```ruby
describe aws_amplify_branch(app_id: 'APP_ID', branch_name: 'BRANCH_NAME') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="Amplify:Client:GetBranchResult" %}}
