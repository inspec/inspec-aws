+++
title = "aws_ec2_dhcp_options resource"

draft = false


[menu.aws]
title = "aws_ec2_dhcp_options"
identifier = "inspec/resources/aws/aws_ec2_dhcp_options resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_dhcp_options` InSpec audit resource to test properties of multiple AWS DHCP options sets.

## Syntax

Ensure that an `aws_ec2_dhcp_options` exists.

```ruby
describe aws_ec2_dhcp_options do
  it { should exist }
end
```

```ruby
describe aws_ec2_dhcp_options.where(dhcp_options_id: 'dopt-0123456789abcdefg') do
  it { should exist }
end
```

## Properties

`domain_names`
: The list of DHCP configurations domain names.

`domain_name_servers`
: The list of domain name servers in the DHCP configuration.

`ntp_servers`
: The list of ntp servers in the DHCP configuration.

`netbios_name_servers`
: The list of NetBIOS name servers in the DHCP configuration.

`netbios_node_types`
: The list of NetBIOS node types in the DHCP configuration.

`tags`
: The tags of the DHCP options.

## Examples

This resource does not have any examples.

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeDhcpOptionsResult" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
