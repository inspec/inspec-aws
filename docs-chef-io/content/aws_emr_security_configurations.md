+++
title = "aws_emr_security_configurationss resource"

draft = false


[menu.aws]
title = "aws_emr_security_configurationss"
identifier = "inspec/resources/aws/aws_emr_security_configurationss resource"
parent = "inspec/resources/aws"
+++

Use the `aws_emr_security_configurations` resource to test the properties of collection for AWS EMR security configuration.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EMR security configuration](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-emr-securityconfiguration.html).

## Syntax

```ruby
describe aws_emr_security_configurations do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`security_configuration_names`
: The name of the security configuration.

: **Field**: `name`

`encryption_at_rest`
: Specifies whether at-rest encryption is enabled for the cluster.

: **Field**: `security_configuration(EncryptionConfiguration(EnableAtRestEncryption))`

`encryption_in_transit`
: Specifies whether in-transit encryption is enabled for the cluster.

: **Field**: `security_configuration(EncryptionConfiguration(EnableInTransitEncryption))`

`local_disk_encryption`
: Specifies whether local-disk encryption is enabled for the cluster.

: **Field**: `security_configuration(EncryptionConfiguration(AtRestEncryptionConfiguration(LocalDiskEncryptionConfiguration)))`

## Examples

Ensure AWS EMR security configurations exists:

```ruby
describe aws_emr_security_configurations do
  it { should exist }
  its('encryption_at_rests') { should include encryption_at_rest }
  its('encryption_in_transits') { should include encryption_in_transit }
  its('local_disk_encryptions') { should include local_disk_encryption }
end
```

## Matchers

For a full list of available matchers, visit the [InSpec matchers page](https://docs.chef.io/inspec/matchers/).

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

{{% inspec-aws/aws_permissions_principal action="EMR:Client:DescribeSecurityConfigurationOutput" %}}
