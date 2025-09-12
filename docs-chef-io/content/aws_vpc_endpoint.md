+++
title = "aws_vpc_endpoint resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_vpc_endpoint"
identifier = "inspec/resources/aws/aws_vpc_endpoint resource"
parent = "inspec/resources/aws"
+++

Use the `aws_vpc_endpoint` InSpec audit resource to test properties of a single specific AWS VPC Endpoint.

A VPC Endpoint is uniquely identified by the VPC Endpoint ID (e.g vpce-123456abcdef12345)

For additional information, including details on parameters and properties, see the [AWS documentation on VPC Endpoints](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-endpoints.html).

## Syntax

Ensure that a VPC Endpoint exists.

    # Find a VPC Endpoint by ID

```ruby
describe aws_vpc_endpoint('vpce-12345678987654321') do
  it { should exist }
end
```

    # Hash syntax for ID

```ruby
describe aws_vpc_endpoint(vpc_endpoint_id: 'vpce-12345678987654321') do
  it { should exist }
end
```

Ensure that a VPC Endpoint is available.

```ruby
describe aws_vpc_endpoint('vpce-12345678987654321') do
  its('state') { should be 'available' }
end
```

    # Alternative using a matcher

```ruby
describe aws_vpc_endpoint('vpce-12345678987654321') do
  its('state') { should be_available }
end
```

Confirm that the route table configured to a VPC Endpoint is as expected.

```ruby
describe aws_vpc_endpoint('vpce-12345678987654321') do
  its('route_table_ids') { should include 'rtb-1234456123456abcde' }
end
```

Confirm that the type of a VPC Endpoint is as expected.

```ruby
describe aws_vpc_endpoint('vpce-12345678987654321') do
  its('vpc_endpoint_type') { should be 'Gateway' }
end
```

    # Alternative using a matcher

```ruby
describe aws_vpc_endpoint('vpce-12345678987654321') do
  its('vpc_endpoint_type') { should be_gateway }
end
```

## Parameters

`vpc_endpoint_id`

: The VPC endpoint ID.
  This can be passed either as a string or as a `vpc_endpoint_id: 'value'` key-value entry in a hash.

## Properties

`vpc_endpoint_id`
: The ID of the endpoint.

`vpc_endpoint_type`
: One of "Interface", "Gateway".

`vpc_id`
: The ID of the VPC in which the endpoint resides.

`state`
: State of the VPC Endpoint. One of "pendingacceptance", "pending", "available", "deleting", "deleted", "rejected", "failed", "expired".

`route_table_ids`
: The route table IDs for the Gateway type endpoint.

`subnet_ids`
: The subnet IDs for the Interface type endpoint.

`groups`
: The Security Groups for the Interface type endpoint.

`private_dns_enabled`
: Boolean value for Private DNS enable status.

`network_interface_ids`
: The Network Interface IDs for the Interface type endpoint.

`dns_entries`
: The DNS Entries for the VPC Endpoint.

`tags`
: The key/value combination of a tag assigned to the resource.

## Examples

Ensure a VPC Endpoint is available:

```ruby
describe aws_vpc_endpoint(vpc_endpoint_id: 'vpce-12345678987654321') do
  its('state') { should eq 'available' }
end
```

Ensure that the endpoint is of Gateway type:

```ruby
describe aws_vpc_endpoint(vpc_endpoint_id: 'vpce-12345678987654321') do
    its('vpc_endpoint_type') { should eq 'Gateway' }
end
```

Check tags    :

```ruby
describe aws_vpc_endpoint do
  its('tags') { should include(:Environment => 'env-name',
                               :Name => 'vpce-name')}
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the describe returns at least one result.

### exist

Use `should_not` to test the entity should not exist.

```ruby
describe aws_vpc_endpoint(vpc_endpoint_id: 'vpce-12345678987654321') do
  it { should exist }
end
```

```ruby
describe aws_vpc_endpoint(vpc_endpoint_id: 'vpce-12345678987654321') do
  it { should_not exist }
end
```

### be_available

Checks if the VPC Endpoint is in available state.
Use `should_not` to test the entity should not exist.

```ruby
describe aws_vpc_endpoint(vpc_endpoint_id: 'vpce-12345678987654321') do
  it { should be_available }
end
```

```ruby
describe aws_vpc_endpoint(vpc_endpoint_id: 'vpce-12345678987654321') do
  it { should_not be_available }
end
```

### be_interface

Checks if the VPC Endpoint type is Interface.
Use `should_not` to test the entity should not exist.

```ruby
describe aws_vpc_endpoint(vpc_endpoint_id: 'vpce-12345678987654321') do
  it { should be_interface }
end
```

```ruby
describe aws_vpc_endpoint(vpc_endpoint_id: 'vpce-12345678987654321') do
  it { should_not be_interface }
end
```

### be_gateway

Checks if the VPC Endpoint type is Gateway.
Use `should_not` to test the entity should not exist.

```ruby
describe aws_vpc_endpoint(vpc_endpoint_id: 'vpce-12345678987654321') do
  it { should be_gateway }
end
```

```ruby
describe aws_vpc_endpoint(vpc_endpoint_id: 'vpce-12345678987654321') do
  it { should_not be_gateway }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeVpcEndpointsResult" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
