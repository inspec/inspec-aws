---
title: About the aws_vpc_endpoints Resource
platform: aws
---

# aws\_vpc\_endpoints

Use the `aws_vpc_endpoints` InSpec audit resource to test properties of some or all AWS VPC Endpoints.

VPC Endpoints can be of two types: 'Gateway' and 'Interface'.

A Gateway type VPC endpoint accepts a route-table whereas an Interface type VPC endpoint takes one or more subnets and one or more security groups. Hence their properties might differ based on the type.

## Syntax

Ensure that one or more VPC Endpoints exist.

    describe aws_vpc_endpoints do
      it { should exist }
    end

An `aws_vpc_endpoints` resource block uses an optional filter to select a group of VPC Endpoints and then tests that group.

## Parameters

This resource does not expect any parameters.

See also the [AWS documentation on VPC Endpoints](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-endpoints.html).

## Properties

|Property           | Description|
| ---               | --- |
|vpc\_endpoint\_ids       | This property provides a list of the VPC Endpoint IDs that the matched VPC Endpoints serve as strings. |
|vpc\_endpoint\_types | The type of the VPC Endpoint for the match VPC Endpoints. |
|vpc\_ids           | The IDs of the VPCs in which the endpoints reside. |
|service_names | The names of the services that the VPC endpoint is assigned with . |
|states | The states of the VPC Endpoints. |
|route_table_ids | The route table IDs for the Gateway type endpoints. |
|subnet_ids | The subnet IDs for the Interface type endpoints. |
|tags               | A hash of key-value pairs corresponding to the tags associated with the entity. |
|private_dns_enabled            | Boolean value for Private DNS enable status. |

## Examples

##### Ensure a VPC has VPC Endpoints.
    describe aws_vpc_endpoints.where( vpc_id: vpc-12345678 )
      it { should exist }
    end

##### Match count of VPC Endpoints of Gateway type in a particular VPC.
    describe aws_vpc_endpoints.where( vpc_id: vpc-12345678 ).where(vpc_endpoint_type: "Gateway") do
        its('count') { should eq 4 }
    end

##### Check tags    
    describe aws_vpc_endpoints do
      its('tags') { should include(:Environment => 'env-name',
                                   :Name => 'vpce-name')}
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

#### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

    describe aws_vpc_endpoints do
      it { should exist }
    end
      
    describe aws_vpc_endpoints.where( <property>: <value>) do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:DescribeVpcEndpoints` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
