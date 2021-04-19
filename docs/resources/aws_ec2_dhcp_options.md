---
title: About the aws_ec2_dhcp_options Resource
platform: aws
---

# aws\_ec2\_dhcp\_options

Use the `aws_ec2_dhcp_options` InSpec audit resource to test properties of a single AWS DHCP Options.

## Syntax

Ensure that an `aws_ec2_dhcp_options` exists

    describe aws_ec2_dhcp_options do
      it { should exist }
    end

    describe aws_ec2_dhcp_options.where(dhcp_options_id: 'dopt-0123456789abcdefg') do
      it { should exist }
    end


## Properties

| Property | Description |
| --- | --- |
| domain_names | The list of dhcp configurations domain names|
| domain_name_servers | The list of domain name servers in the dhcp configuration |
| ntp_servers | The list of ntp servers in the dhcp configuration |
| netbios_name_servers | The list of netbios name servers in the dhcp configuration |
| netbios_node_types | The list of netbios node types in the dhcp configuration |
| tags | The tags of the DHCP Options. |


## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:DescribeDhcpOptions` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
