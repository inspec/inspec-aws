+++
title = "aws_emr_security_configuration Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_emr_security_configuration"
identifier = "inspec/resources/aws/aws_emr_security_configuration Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_emr_security_configuration` InSpec audit resource to test properties of the singular resource of AWS EMR security configuration.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EMR security configuration](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-emr-securityconfiguration.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

An `aws_emr_security_configuration` resource block declares the tests for a single AWS EMR security configuration by `security_configuration_name`.

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

## Parameters

`security_configuration_name` _(required)_

: This resource requires a single parameter, the EMR security configuration name.
  This can be passed either as a string or as a `security_configuration_name: 'value'` key-value entry in a hash.

## Properties

`encryption_at_rest`
: Specifies whether at-rest encryption is enabled for the cluster.

`encryption_in_transit`
: Specifies whether in-transit encryption is enabled for the cluster.

`local_disk_encryption`
: Specifies whether local-disk encryption is enabled for the cluster.

## Examples

**Test that an EMR security configuration has at-rest encryption enabled.**

```ruby
describe aws_emr_security_configuration('SECURITY_CONFIGURATION_NAME') do
  its ('encryption_at_rest') { should eq true }
end
```

**Test that an EMR security configuration has in-transit encryption enabled.**

```ruby
describe aws_emr_security_configuration('SECURITY_CONFIGURATION_NAME') do
  its ('encryption_in_transit') { should eq true }
end
```

**Test that an EMR security configuration has local-disk encryption enabled.**

```ruby
describe aws_emr_security_configuration('SECURITY_CONFIGURATION_NAME') do
  its ('local_disk_encryption') { should eq true }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

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

{{% inspec-aws/aws_permissions_principal action="EMR:Client:DescribeSecurityConfigurationOutput" %}}
