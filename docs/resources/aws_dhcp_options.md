---
title: About the aws_dhcp_options Resource
platform: aws
---
# aws\_dhcp\_options

**DEPRECATION NOTICE**

The **aws_dhcp_options** InSpec audit resource is deprecated and replaced by the `aws_ec2_dhcp_option` and `aws_ec2_dhcp_options` resources.

Use the `aws_dhcp_options` InSpec audit resource to test properties of a single AWS DHCP Options.

## Syntax

Ensure that an `aws_dhcp_options` exists

    describe aws_dhcp_options('dopt-0123456789abcdefg') do
      it { should exist }
    end

    describe aws_dhcp_options(dhcp_options_id: 'dopt-0123456789abcdefg') do
      it { should exist }
    end

### Parameters

#### dhcp\_options\_id _(required)_

This resource accepts a single parameter, the DHCP Options ID which uniquely identifies the DHCP Options.
This can be passed either as a string or as a `dhcp_options_id: 'value'` key-value entry in a hash.

See also the [AWS documentation on EC2](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeDhcpOptions.html).

## Properties

| Property | Description |
| --- | --- |
| dhcp_configurations | The list of dhcp configurations |
| domain_name_servers | The list of domain name servers in the dhcp configuration |
| ntp_servers | The list of ntp servers in the dhcp configuration |
| tags | The tags of the DHCP Options. |

## Examples
### Test tags on the DHCP options

    describe aws_dhcp_options('dopt-0123456789abcdefg') do
      its('tags') { should include(:Environment => 'env-name',
                                   :Name => 'dhcp-options-name')}
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeDhcpOptionsResult` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
