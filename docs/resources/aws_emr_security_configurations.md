---
title: About the aws_emr_security_configurationss Resource
platform: aws
---

# aws_emr_security_configurations

Use the `aws_emr_security_configurations` resource to test the properties of collection for AWS EMR security configuration.

## Syntax

```ruby
describe aws_emr_security_configurations do
  it { should exist }
end
```

### Parameters

This resource does not expect any parameters.

See also the [AWS documentation on AWS EMR security configuration](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-emr-securityconfiguration.html).

## Properties

|Property                              | Description|Fields |
| ---                                  | --- |---|
|security_configuration_names          |The name of the security configuration.|name|
|encryption_at_rest                    | Specifies whether at-rest encryption is enabled for the cluster.|security_configuration(EncryptionConfiguration(EnableAtRestEncryption))|
|encryption_in_transit                 | Specifies whether in-transit encryption is enabled for the cluster.|security_configuration(EncryptionConfiguration(EnableInTransitEncryption))|
|local_disk_encryption                 | Specifies whether local-disk encryption is enabled for the cluster. |security_configuration(EncryptionConfiguration(AtRestEncryptionConfiguration(LocalDiskEncryptionConfiguration)))|

## Examples

#### Ensure AWS EMR security configurations exists

```ruby
describe aws_emr_security_configurations do
  it { should exist }
  its('encryption_at_rests') { should include encryption_at_rest }
  its('encryption_in_transits') { should include encryption_in_transit }
  its('local_disk_encryptions') { should include local_disk_encryption }
end
```

## Matchers

For a full list of available matchers, please visit our [matchers page](https://docs.chef.io/inspec/matchers/).

### exist

Use `should` to test an entity that should exist.

```ruby
describe aws_emr_security_configurations.where(security_configuration_name: 'SECURITY_CONFIGURATION_NAME') do
  it { should exist }
end
```

Use `should_not` to test an entity that should not exist.

```ruby
describe aws_emr_security_configurations.where(security_configuration_name: 'INVALID_SECURITY_CONFIGURATION_NAME') do
  it { should_not exist }
end
```

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EMR:Client:DescribeSecurityConfigurationOutput` action with `Effect` set to `Allow`.
