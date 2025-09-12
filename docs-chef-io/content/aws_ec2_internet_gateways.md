+++
title = "aws_ec2_internet_gateways resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ec2_internet_gateways"
identifier = "inspec/resources/aws/aws_ec2_internet_gateways resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_internet_gateways` InSpec audit resource to test properties of multiple AWS EC2 internet gateways.

The `AWS::EC2::InternetGateway` resource allocates an internet gateway for use with a VPC. After creating the internet gateway, you then attach it to a VPC.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 internet gateway](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-internetgateway.html).

## Syntax

Ensure that an internet gateway exists.

```ruby
describe aws_ec2_internet_gateways do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`attachments`
: The attachments of the internet gateways.

: **Field**: `attachments`

`attachments_states`
: The current attachment states. For an internet gateway, the state is available when attached to a VPC; otherwise, this value is not returned.

: **Field**: `attachments (state)`

`attachments_vpc_ids`
: The IDs of the VPCs.

: **Field**: `attachments (vpc_id)`

`internet_gateway_ids`
: The IDs of the internet gateways.

: **Field**: `internet_gateway_id`

`owner_ids`
: The IDs of the AWS accounts that own the internet gateways.

: **Field**: `owner_id`

`tags`
: The key/value combination of tags assigned to the resources.

: **Field**: `tags`

## Examples

Ensure an attachment is available:

```ruby
describe aws_ec2_internet_gateways do
  its('attachments') { should_not be_empty }
end
```

Ensure that an attachment state is `available`:

```ruby
describe aws_ec2_internet_gateways do
    its('attachments_states') { should include 'available' }
end
```

Ensure an internet gateway ID is available:

```ruby
describe aws_ec2_internet_gateways do
  its('internet_gateway_ids') { should include 'INTERNET_GATEWAY_ID' }
end
```

Ensure an owner ID is available:

```ruby
describe aws_ec2_internet_gateways do
  its('owner_ids') { should include 'OWNER_ID' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_internet_gateways do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ec2_internet_gateways do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeInternetGatewaysResult" %}}
