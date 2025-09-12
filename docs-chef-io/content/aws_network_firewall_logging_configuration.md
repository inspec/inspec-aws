+++
title = "aws_network_firewall_logging_configuration resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_network_firewall_logging_configuration"
identifier = "inspec/resources/aws/aws_network_firewall_logging_configuration resource"
parent = "inspec/resources/aws"
+++

Use the `aws_network_firewall_logging_configuration` InSpec audit resource to test properties of a single specific AWS Network Firewall Logging Configuration.

The `AWS::NetworkFirewall::LoggingConfiguration` resource defines the destinations and logging options for an [`AWS::NetworkFirewall::Firewall`](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-firewall.html).

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Network Firewall Logging Configuration](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-loggingconfiguration.html).

## Syntax

Ensure that the firewall exists.

```ruby
describe aws_network_firewall_logging_configuration(firewall_name: 'FIREWALL_NAME') do
  it { should exist }
end
```

## Parameters

`firewall_name` _(required)_

: The Amazon Resource Name (ARN) of the firewall.

## Properties

`firewall_arn`
: The Amazon Resource Name (ARN) of the firewall.

`logging_configuration_log_destination_configs_log_type`
: The type of log to send.

`logging_configuration_log_destination_configs_log_destination_type`
: The type of storage destination to send these logs to.

`logging_configuration_log_destination_configs_log_destination`
: The named location for the logs, provided in a key:value mapping that is specific to the chosen destination type.

## Examples

**Ensure a firewall ARN is available.**

```ruby
describe aws_network_firewall_logging_configuration(firewall_name: 'FIREWALL_NAME') do
  its('firewall_arn') { should eq 'FIREWALL_ARN' }
end
```

**Ensure that the log type is available.**

```ruby
describe aws_network_firewall_logging_configuration(firewall_name: 'FIREWALL_NAME') do
    its('logging_configuration_log_destination_configs_log_type') { should eq 'LOG_TYPE' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_network_firewall_logging_configuration(firewall_name: 'FIREWALL_NAME') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_network_firewall_logging_configuration(firewall_name: 'FIREWALL_NAME') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_network_firewall_logging_configuration(firewall_name: 'FIREWALL_NAME') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="NetworkFirewall:Client:DescribeFirewallResponse" %}}
