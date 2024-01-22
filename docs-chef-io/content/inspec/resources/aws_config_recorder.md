+++
title = "aws_config_recorder Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_config_recorder"
identifier = "inspec/resources/aws/aws_config_recorder Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_config_recorder` InSpec audit resource to test properties of your AWS Config service.

The AWS Config service can monitor and record changes to your AWS resource configurations.  The AWS Config recorder is used to detect changes in resource configurations and capture these changes as configuration items.

As of April 2018, you are only permitted one configuration recorder per region.

For additional information, including details on parameters and properties, see the [AWS documentation on the `AWS::Config::ConfigurationRecorder` resource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-config-configurationrecorder.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

An `aws_config_recorder` resource block declares the tests for a single AWS Config resource by recorder name.

```ruby
describe aws_config_recorder('RECORDER_NAME') do
  it { should exist }
end
```

You may also use hash syntax to pass the recorder name

```ruby
describe aws_config_recorder(recorder_name: 'RECORDER_NAME') do
  it { should exist }
end
```

Since you may only have one recorder per region, and InSpec connections are per-region, you may also omit the recorder name to obtain the one recorder (if any) that exists:

```ruby
describe aws_config_recorder do
  it { should exist }
end
```

## Parameters

`recorder_name` _(optional)_

: This resource accepts a single parameter, the Configuration recorder name.
  This can be passed either as a string or as a `recorder_name: 'value'` key-value entry in a hash.

## Properties

`recorder_name`
: The name of the recorder. By default, AWS Config automatically assigns the name "default" when creating the configuration recorder. You cannot change the assigned name.

`role_arn`
: Amazon Resource Name (ARN) of the IAM role used to describe the AWS resources associated with the account.

`resource_types`
: A comma-separated list that specifies the types of AWS resources for which AWS Config records configuration changes (i.e. AWS::EC2::Instance).

`last_status`
: The last (previous) status of the recorder.

## Examples

**Test if the recorder is active and recording.**

```ruby
describe aws_config_recorder do
  it { should be_recording }
end
```

**Ensure the role_arn is correct for the recorder.**

The role is used to grant permissions to S3 Buckets, SNS topics and to get configuration details for supported AWS resources.

```ruby
describe aws_config_recorder do
  its('role_arn') { should eq 'arn:aws:iam::721741954427:role/My_Recorder' }
end
```

**Test the recorder is monitoring changes to the correct resources.**

```ruby
describe aws_config_recorder do
  its('resource_types') { should include 'AWS::EC2::CustomerGateway' }
  its('resource_types') { should include 'AWS::EC2::EIP' }
end
```

**Test the recorder's last status.**

```ruby
describe aws_config_recorder do
  its('last_status') { should eq 'SUCCESS' }
end
```

## Matchers

### be_recording

Ensure the recorder is active

```ruby
it { should be_recording }
```

### be_recording_all_resource_types

Indicates if the configuration recorder will record changes for all resources, regardless of type. If this is true, resource_types is ignored.

```ruby
it { should be_recording_all_resource_types }
```

### be_recording_all_global_types

Indicates whether the configuration recorder will record changes for global resource types (such as [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal)s).

```ruby
it { should be_recording_all_global_types }
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="ConfigService:Client:DescribeConfigurationRecordersResponse" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for AWS Config](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_awsconfig.html).
