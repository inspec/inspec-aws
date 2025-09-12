+++
title = "aws_ec2_egress_only_internet_gateway resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ec2_egress_only_internet_gateway"
identifier = "inspec/resources/aws/aws_ec2_egress_only_internet_gateway resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_egress_only_internet_gateway` InSpec audit resource to test properties of a single specific AWS EC2 egress-only internet gateway.

The `AWS::EC2::EgressOnlyInternetGateway` specifies an egress-only internet gateway for your VPC.

## Syntax

Ensure that the egress-only internet gateway Id exists.

```ruby
describe aws_ec2_egress_only_internet_gateway(egress_only_internet_gateway_id: 'EGRESS_ONLY_INTERNET_GATEWAY_ID') do
  it { should exist }
end
```

## Parameters

`egress_only_internet_gateway_id` _(required)_

: The ID of the egress-only internet gateway.

: For additional information, see the [AWS documentation on AWS EC2 egress-only internet gateway.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-egressonlyinternetgateway.html).

## Properties

`attachments`
: Information about the attachment of the egress-only internet gateway.

`attachments_states`
: The current state of the attachment.

`attachments_vpc_ids`
: The ID of the VPC.

`egress_only_internet_gateway_id`
: The ID of the egress-only internet gateway.

`tags`
: The tags assigned to the egress-only internet gateway.

## Examples

**Ensure an egress-only internet gateway ID is available.**

```ruby
describe aws_ec2_egress_only_internet_gateway(egress_only_internet_gateway_id: 'EGRESS_ONLY_INTERNET_GATEWAY_ID') do
  its('egress_only_internet_gateway_id') { should eq 'EGRESS_ONLY_INTERNET_GATEWAY_ID' }
end
```

**Ensure that the attachments states is `attached`.**

```ruby
describe aws_ec2_egress_only_internet_gateway(egress_only_internet_gateway_id: 'EGRESS_ONLY_INTERNET_GATEWAY_ID') do
    its('attachments_states') { should eq 'attached' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_egress_only_internet_gateway(egress_only_internet_gateway_id: 'EGRESS_ONLY_INTERNET_GATEWAY_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ec2_egress_only_internet_gateway(egress_only_internet_gateway_id: 'EGRESS_ONLY_INTERNET_GATEWAY_ID') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_ec2_egress_only_internet_gateway(egress_only_internet_gateway_id: 'EGRESS_ONLY_INTERNET_GATEWAY_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeEgressOnlyInternetGatewaysResult" %}}
