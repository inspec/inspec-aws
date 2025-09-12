+++
title = "aws_dhcp_options resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_dhcp_options"
identifier = "inspec/resources/aws/aws_dhcp_options resource"
parent = "inspec/resources/aws"
+++
DEPRECATION NOTICE**

The **aws_dhcp_options** InSpec audit resource is deprecated and replaced by the `aws_ec2_dhcp_option` and `aws_ec2_dhcp_options` resources.

Use the `aws_dhcp_options` InSpec audit resource to test properties of a single AWS DHCP Options.

For additional information, including details on parameters and properties, see the [AWS documentation on EC2](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeDhcpOptions.html).

## Syntax

Ensure that an `aws_dhcp_options` exists

```ruby
describe aws_dhcp_options('dopt-0123456789abcdefg') do
  it { should exist }
end
```

```ruby
describe aws_dhcp_options(dhcp_options_id: 'dopt-0123456789abcdefg') do
  it { should exist }
end
```

## Parameters

`dhcp_options_id` _(required)_

: This resource accepts a single parameter, the DHCP Options ID which uniquely identifies the DHCP Options.
  This can be passed either as a string or as a `dhcp_options_id: 'value'` key-value entry in a hash.

## Properties

`dhcp_configurations`
: The list of dhcp configurations.

`domain_name_servers`
: The list of domain name servers in the dhcp configuration.

`ntp_servers`
: The list of ntp servers in the dhcp configuration.

`tags`
: The tags of the DHCP Options.

## Examples

Test tags on the DHCP options:

```ruby
describe aws_dhcp_options('dopt-0123456789abcdefg') do
  its('tags') { should include(:Environment => 'env-name',
                               :Name => 'dhcp-options-name')}
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeDhcpOptionsResult" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
