+++
title = "aws_amplify_branches resource"

draft = false


[menu.aws]
title = "aws_amplify_branches"
identifier = "inspec/resources/aws/aws_amplify_branches resource"
parent = "inspec/resources/aws"
+++

Use the `aws_amplify_branches` InSpec audit resource to test the properties of multiple AWS Amplify branches.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Amplify branch](https://docs.aws.amazon.com/amplify/latest/APIReference/API_App.html).

## Syntax

Ensure that AWS Amplify branch exists.

```ruby
describe aws_amplify_branches(app_id: 'APP_ID') do
  it { should exist }
end
```

## Parameters

`app_id` _(required)_

: The unique ID for an Amplify app.

## Properties

`branch_arns`
: The Amazon Resource Name (ARN) for a branch that is part of an Amplify app.

: **Field**: `branch_arn`

`branch_names`
: The name for the branch that is part of an Amplify app.

: **Field**: `branch_name`

`descriptions`
: The description for the branch that is part of an Amplify app.

: **Field**: `description`

`tags`
: The tag for the branch of an Amplify app.

: **Field**: `tags`

`stage`
: The current stage for the branch that is part of an Amplify app.

: **Field**: `stage`

`display_names`
: The display_name for the Amplify branch.

: **Field**: `display_name`

`platforms`
: The platform for the Amplify branch.

: **Field**: `platform`

`create_time`
: Creates a date and time for the Amplify branch.

: **Field**: `create_time`

`update_time`
: Updates the date and time for the Amplify branch.

: **Field**: `update_time`

`environment_variables`
: The environment variables for the Amplify branch.

: **Field**: `environment_variables`

`enable_pull_request_preview`
: The app engine version to upgrade to.

: **Field**: `enable_pull_request_preview`

`custom_domains`
: The custom domain for the Amplify branch.

: **Field**: `custom_domain`

`pull_request_environment_names`
: Automatically disconnect a branch in the Amplify Console when you delete a branch from your Git repository.

: **Field**: `pull_request_environment_name`

`enable_basic_auth`
: Enables basic authorization for the Amplify branch's branches.

: **Field**: `enable_basic_auth`

## Examples

Ensure a branch ID is available:

```ruby
describe aws_amplify_branches(app_id: 'APP_ID') do
  its('branch_arns') { should include 'BranchARN' }
end
```

Ensure a branch name is available:

```ruby
describe aws_amplify_branches(app_id: 'APP_ID') do
    its('branch_names') { should include 'BranchName' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_amplify_branches(app_id: 'APP_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_amplify_branches(app_id: 'dummy') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the Amplify branch is available.

```ruby
describe aws_amplify_branches(app_id: 'APP_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="Amplify:Client:ListBranchesResult" %}}
