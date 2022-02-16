---
title: About the aws_ec2_dhcp_option Resource
platform: aws
---

# aws_ec2_dhcp_option

Use the `aws_ec2_dhcp_option` InSpec audit resource to test the properties of a single AWS DHCP options set.

## Syntax

Ensure that an `aws_ec2_dhcp_option` exists.

    describe aws_ec2_dhcp_option('dopt-0123456789abcdefg') do
      it { should exist }
    end

    describe aws_ec2_dhcp_option(dhcp_options_id: 'dopt-0123456789abcdefg') do
      it { should exist }
    end

    describe aws_ec2_dhcp_option(name: 'dopt-vpc-1') do
        it { should exist }
    end

### Parameters

This resource requires either the `dhcp_options_id` or `name` parameter.

`dhcp_options_id` _(required)_

The DHCP options ID uniquely identifies the DHCP options set.
This can be passed either as a string or as a `dhcp_options_id: 'value'` key-value entry in a hash.

`name` _(required)_

The DHCP options name uniquely identifies the DHCP options set.
This can be passed as a `name: 'value'` key-value entry in a hash.

See also the [AWS documentation on EC2 DHCP Options](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeDhcpOptions.html).

## Properties

| Property | Description |
| :---: | :--- |
| domain_name | The configured AWS DNS name. |
| domain_name_servers | The list of domain name servers in the DHCP configuration. |
| ntp_servers | The list of ntp servers in the DHCP configuration. |
| netbios_name_servers | The list of NetBIOS name servers in the DHCP configuration. |
| netbios_node_type | The type of NetBIOS node in the DHCP configuration. |
| tags | The tags of the DHCP options. |

## Examples

### Test tags on the DHCP options

    describe aws_ec2_dhcp_option('dopt-0123456789abcdefg') do
      its('tags') { should include(:Environment => 'env-name',
                                   :Name => 'dhcp-options-name')}
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeDhcpOptionsResult` action with `Effect` set to `Allow`.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
