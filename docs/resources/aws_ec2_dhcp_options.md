---
title: About the aws_ec2_dhcp_options Resource
platform: aws
---

# aws_ec2_dhcp_options

Use the `aws_ec2_dhcp_options` InSpec audit resource to test the properties of multiple AWS DHCP options sets.

## Syntax

Ensure that an `aws_ec2_dhcp_options` exists.

    describe aws_ec2_dhcp_options do
      it { should exist }
    end

    describe aws_ec2_dhcp_options.where(dhcp_options_id: 'DOPT-0123456789ABCDEFG') do
      it { should exist }
    end


## Properties

| Property | Description |
| --- | --- |
| domain_names          | The list of the DHCP configurations domain names. |
| domain_name_servers   | The list of the domain name servers in the DHCP configuration. |
| ntp_servers           | The list of the NTP servers in the DHCP configuration. |
| netbios_name_servers  | The list of the NetBIOS name servers in the DHCP configuration. |
| netbios_node_types    | The list of the NetBIOS node types in the DHCP configuration. |
| tags                  | The tags of the DHCP options. |

## Examples

This resource does not have any examples.

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:DescribeDhcpOptions` action with **Effect** set to `Allow`.

You can find the detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).