---
title: About the aws_emr_security_configuration Resource
platform: aws
---

# aws\_emr\_security\_configuration

Use the `aws_emr_security_configuration` InSpec audit resource to test properties of the singular resource of AWS EMR Security Configuration.

## Syntax

An `aws_emr_security_configuration` resource block declares the tests for a single AWS EMR Security Configuration by `security_configuration_name`.
```ruby
describe aws_emr_security_configuration(security_configuration_name: 'SECURITY_CONFIGURATION_NAME') do
  it { should exist }
end
```
```ruby
describe aws_emr_security_configuration('SECURITY_CONFIGURATION_NAME') do
  it { should exist }
end
```
#### Parameters

##### `security_configuration_name` _(required)_

This resource requires a single parameter, the EMR Security Configuration name.
This can be passed either as a string or as a `security_configuration_name: 'value'` key-value entry in a hash.

See also the [AWS documentation on AWS EMR Security Configuration](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-emr-securityconfiguration.html).

## Properties

|Property                                | Description|
| ---                                    | --- |
|encryption\_at\_rest                    | Specifies whether at-rest encryption is enabled for the culster.|
|encryption\_in\_transit                 | Specifies whether in-transit encryption is enabled for the culster.|
|local\_disk\_encryption                 | Specifies whether local-disk encryption is enabled for the cluster. |
              
## Examples


#### Test that an EMR Cluster does not exist
```ruby
describe aws_emr_security_configuration(security_configuration_name: 'INVALID_SECURITY_CONFIGURATION_NAME') do
  it { should_not exist }
end
```
#### Test that an EMR Security Configuration's at-rest encryption is enabled
```ruby
describe aws_emr_security_configuration('SECURITY_CONFIGURATION_NAME') do
  its ('encryption_at_rest') { should eq true }
end
```
#### Test that an EMR Security Configuration's in-transit encryption is enabled
```ruby
describe aws_emr_security_configuration('SECURITY_CONFIGURATION_NAME') do
  its ('encryption_in_transit') { should eq true }
end
```
#### Test that an EMR Security Configuration's local-disk encryption is enabled
```ruby
describe aws_emr_security_configuration('SECURITY_CONFIGURATION_NAME') do
  its ('local_disk_encryption') { should eq true }
end
```
## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

#### exist

The control will pass if the describe returns at least one result.

Use `should` to test the entity should exist.
```ruby
describe aws_emr_security_configuration('SECURITY_CONFIGURATION_NAME') do
  it { should exist }
end
```

Use `should_not` to test the entity should not exist.
```ruby
describe aws_emr_security_configuration('SECURITY_CONFIGURATION_NAME') do
  it { should_not exist }
end
```

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EMR:Client:DescribeSecurityConfigurationOutput` action set to allow.

