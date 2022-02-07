---
title: About the aws_amplify_branches resource
platform: aws
---

# aws_amplify_branches

Use the `aws_amplify_branches` InSpec audit resource to test the properties of multiple AWS Amplify branches.

## Syntax

Ensure that AWS Amplify branch exists.

    describe aws_amplify_branches(app_id: 'APP_ID') do
      it { should exist }
    end

## Parameters

`app_id` _(required)_

The unique ID for an Amplify app.

For additional information, see the [AWS documentation on AWS Amplify branch](https://docs.aws.amazon.com/amplify/latest/APIReference/API_App.html).

## Properties

| Property | Description| Field|
| --- | --- | --- |
| branch_arns | The Amazon Resource Name (ARN) for a branch that is part of an Amplify app. | branch_arn |
| branch_names | The name for the branch that is part of an Amplify app. | branch_name |
| descriptions | The description for the branch that is part of an Amplify app. | description |
| tags | The tag for the branch of an Amplify app. | tags |
| stage | The current stage for the branch that is part of an Amplify app. | stage |
| display_names | The display_name for the Amplify branch. | display_name |
| platforms | The platform for the Amplify branch. | platform |
| create_time | Creates a date and time for the Amplify branch. | create_time |
| update_time | Updates the date and time for the Amplify branch.  | update_time |
| environment_variables | The environment variables for the Amplify branch. | environment_variables |
| enable_pull_request_preview | The app engine version to upgrade to.  | enable_pull_request_preview |
| custom_domains | The custom domain for the Amplify branch. | custom_domain |
| pull_request_environment_names | Automatically disconnect a branch in the Amplify Console when you delete a branch from your Git repository. | pull_request_environment_name |
| enable_basic_auth |Enables basic authorization for the Amplify branch's branches. | enable_basic_auth |

## Examples

### Ensure a branch ID is available.

    describe aws_amplify_branches(app_id: 'APP_ID') do
      its('branch_arns') { should include 'BranchARN' }
    end

### Ensure a branch name is available.

    describe aws_amplify_branches(app_id: 'APP_ID') do
        its('branch_names') { should include 'BranchName' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_amplify_branches(app_id: 'APP_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_amplify_branches(app_id: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the Amplify branch is available.

    describe aws_amplify_branches(app_id: 'APP_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `Amplify:Client:ListBranchesResult` action with `Effect` set to `Allow`.
