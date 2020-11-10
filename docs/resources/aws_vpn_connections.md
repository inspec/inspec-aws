---
title: About the aws_vpn_connections Resource
platform: aws
---

# aws\_vpn\_connections

Use the `aws_vpn_connections` InSpec audit resource to test properties of all AWS VPN Connections.

## Syntax

Ensure that one or more VPN Connections exist.

    describe aws_vpn_connections do
      it { should exist }
    end

## Parameters

This resource does not expect any parameters.

See also the [AWS documentation on VPN Connections](https://docs.aws.amazon.com/vpc/latest/userguide/vpn-connections.html).

## Properties

|Property           | Description|
| ---               | --- |
|vpn\_connection\_id    | This property provides all the IDs of the VPN Connections |
|vpn\_gateway\_id       | This property provides all the IDs of the virtual private gateways associated with the VPN Connections |
|tunnel\_options        | This property provides the tunnel options of the VPN Connections. |
|state                  | This property provides the current state of the VPN Connections |

## Examples

##### Ensure that VPN connections are available.
    describe aws_vpn_connections do
      its('state') { should eq 'available' }
    end

##### Check tags    
    describe aws_vpn_connections do
      its('tags') { should include(:Name => 'vpn-connection-example-123')}
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

#### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

    describe aws_vpn_connections do
      it { should exist }
    end
      
    describe aws_vpn_connections do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:DescribeVpnConnections` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
