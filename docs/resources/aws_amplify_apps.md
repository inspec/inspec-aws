---
title: About the aws_amplify_apps resource
platform: aws
---

# aws\_amplify\_apps

Use the `aws_amplify_apps` InSpec audit resource to test the properties of Multiple AWS Amplify apps.

## Syntax

Ensure that AWS Amplify app exists.

    describe aws_amplify_apps  do
      it { should exist }
    end


## Parameters

This resource does not require any parameters.

For additional information, see the [AWS documentation on AWS Amplify App](https://docs.aws.amazon.com/amplify/latest/APIReference/API_App.html).

## Properties

| Property | Description| Field |
| --- | --- | --- |
| app_arns | The Amazon Resource Name (ARN) of the Amplify app. | app_arn |
| app_ids | The unique ID of the Amplify app. | app_id |
| app_arns | The app's Amazon Resource app_id (ARN). | app_arn |
| names | The name for the Amplify app.| name |
| description | The description for the Amplify app.| description |
| repositories | The repository for the Amplify app. | repository |
| platforms | The platform for the Amplify app. | platform |
| create_time | Creates a date and time for the Amplify app. | create_time |
| update_time | Updates the date and time for the Amplify app.  | update_time |
| environment_variables | The environment variables for the Amplify app. | environment_variables |
| pending_engine_versions | The app engine version to upgrade to.  | pending_engine_version |
| default_domains | The default domain for the Amplify app. | default_domain |
| enable_branch_auto_build |Automatically disconnect a branch in the Amplify Console when you delete a branch from your Git repository. | enable_branch_auto_build |
| enable_basic_auth |Enables basic authorization for the Amplify app's branches. | enable_basic_auth |

## Examples

### Ensure a app ID is available.

    describe aws_amplify_apps  do
      its('app_ids') { should include 'app_id' }
    end

### Ensure a app name is available.

    describe aws_amplify_apps  do
        its('app_names') { should include 'app_name' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `List` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_amplify_apps  do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_amplify_apps  do
      it { should_not exist }
    end

### be_available

Use `should` to check if the Amplify  App is available.

    describe aws_amplify_apps  do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `Amplify:Client:ListAppsResult` action with `Effect` set to `Allow`.
