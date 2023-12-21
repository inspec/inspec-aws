+++
title = "aws_vpc_endpoints Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_vpc_endpoints"
identifier = "inspec/resources/aws/aws_vpc_endpoints Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_vpc_endpoints` InSpec audit resource to test properties of some or all AWS VPC Endpoints.

VPC Endpoints can be of two types: 'Gateway' and 'Interface'.

A Gateway type VPC endpoint accepts a route-table whereas an Interface type VPC endpoint takes one or more subnets and one or more security groups. Hence their properties might differ based on the type.

For additional information, including details on parameters and properties, see the [AWS documentation on VPC Endpoints](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-endpoints.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that one or more VPC Endpoints exist.

```ruby
describe aws_vpc_endpoints do
  it { should exist }
end
```

An `aws_vpc_endpoints` resource block uses an optional filter to select a group of VPC Endpoints and then tests that group.

## Parameters

This resource does not require any parameters.

## Properties

`vpc_endpoint_ids`
: This property provides a list of the VPC Endpoint IDs that the matched VPC Endpoints serve as strings.

`vpc_endpoint_types`
: The type of the VPC Endpoint for the match VPC Endpoints.

`vpc_ids`
: The IDs of the VPCs in which the endpoints reside.

`service_names`
: The names of the services that the VPC endpoint is assigned with .

`states`
: The states of the VPC Endpoints.

`route_table_ids`
: The route table IDs for the Gateway type endpoints.

`subnet_ids`
: The subnet IDs for the Interface type endpoints.

`tags`
: A hash of key-value pairs corresponding to the tags associated with the entity.

`private_dns_enabled`
: Boolean value for Private DNS enable status.

## Examples

**Ensure a VPC has VPC Endpoints.**

```ruby
describe aws_vpc_endpoints.where( vpc_id: vpc-12345678 )
  it { should exist }
end
```

**Match count of VPC Endpoints of Gateway type in a particular VPC.**

```ruby
describe aws_vpc_endpoints.where( vpc_id: vpc-12345678 ).where(vpc_endpoint_type: "Gateway") do
    its('count') { should eq 4 }
end
```

**Check tags    .**

```ruby
describe aws_vpc_endpoints do
  its('tags') { should include(:Environment => 'env-name',
                               :Name => 'vpce-name')}
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_vpc_endpoints do
  it { should exist }
end
```

```ruby
describe aws_vpc_endpoints.where( <property>: <value>) do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeVpcEndpointsResult" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
