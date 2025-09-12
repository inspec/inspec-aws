+++
title = "aws_ec2_dhcp_option resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ec2_dhcp_option"
identifier = "inspec/resources/aws/aws_ec2_dhcp_option resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_dhcp_option` InSpec audit resource to test the properties of a single AWS DHCP options set.

For additional information, including details on parameters and properties, see the [AWS documentation on EC2](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeDhcpOptions.html).

## Syntax

Ensure that an `aws_ec2_dhcp_option` exists.

```ruby
describe aws_ec2_dhcp_option('dopt-0123456789abcdefg') do
  it { should exist }
end
```

```ruby
describe aws_ec2_dhcp_option(dhcp_options_id: 'dopt-0123456789abcdefg') do
  it { should exist }
end
```

```ruby
describe aws_ec2_dhcp_option(name: 'dopt-vpc-1') do
    it { should exist }
end
```

## Parameters

This resource requires either the `dhcp_options_id` or `name` parameter.

`dhcp_options_id`

: The DHCP options ID uniquely identifies the DHCP options set.
  This can be passed either as a string or as a `dhcp_options_id: 'value'` key-value entry in a hash.

`name`

: The DHCP options name uniquely identifies the DHCP options set.
  This can be passed as a `name: 'value'` key-value entry in a hash.

## Properties

`domain_name`
: The configured AWS DNS name.

`domain_name_servers`
: The list of domain name servers in the DHCP configuration.

`ntp_servers`
: The list of ntp servers in the DHCP configuration.

`netbios_name_servers`
: The list of NetBIOS name servers in the DHCP configuration.

`netbios_node_type`
: The type of NetBIOS node in the DHCP configuration.

`tags`
: The tags of the DHCP options.

## Examples

Test tags on the DHCP options:

```ruby
describe aws_ec2_dhcp_option('dopt-0123456789abcdefg') do
  its('tags') { should include(:Environment => 'env-name',
                               :Name => 'dhcp-options-name')}
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeDhcpOptionsResult" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
