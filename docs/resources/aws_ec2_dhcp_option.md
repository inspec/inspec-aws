---
title: About the aws_ec2_dhcp_option Resource
platform: aws
---

# aws_ec2_dhcp_option

Use the `aws_ec2_dhcp_option` InSpec audit resource to test the properties of a single AWS DHCP options set.

## Syntax

Ensure that an `aws_ec2_dhcp_option` exists.

    describe aws_ec2_dhcp_option('DOPT-0123456789ABCDEFG') do
      it { should exist }
    end

    describe aws_ec2_dhcp_option(dhcp_options_id: 'DOPT-0123456789ABCDEFG') do
      it { should exist }
    end

    describe aws_ec2_dhcp_option(name: 'DOPT-VPC-1') do
        it { should exist }
    end

## Parameters

This resource requires either the `DHCP_OPTIONS_ID` or `NAME` parameter.

### dhcp_options_id

The DHCP options ID uniquely identifies the DHCP options set.
This can be passed either as a string or as a `dhcp_options_id: 'VALUE'` key-value entry in a hash.

### name

The DHCP options name uniquely identifies the DHCP options set.
This can be passed as a `name: 'VALUE'` key-value entry in a hash.

See also the [AWS documentation on EC2](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeDhcpOptions.html).

## Properties

| Property  | Description |
| ---       | --- |
| domain_name           | The configured AWS DNS name. |
| domain_name_servers   | The list of the domain name servers in the DHCP configuration. |
| ntp_servers           | The list of the NTP servers in the DHCP configuration. |
| netbios_name_servers  | The list of the NetBIOS name servers in the DHCP configuration. |
| netbios_node_type     | The type of the NetBIOS node in the DHCP configuration. |
| tags                  | The tags of the DHCP options. |


## Examples
### Test tags on the DHCP options

    describe aws_ec2_dhcp_option('DOPT-0123456789ABCDEFG') do
      its('tags') { should include(:Environment => 'ENV-NAME',
                                   :Name => 'DHCP-OPTIONS-NAME')}
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:DescribeDhcpOptions` action with **Effect** set to `Allow`.

You can find the detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).