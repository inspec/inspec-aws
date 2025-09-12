+++
title = "aws_ec2_eip_association resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ec2_eip_association"
identifier = "inspec/resources/aws/aws_ec2_eip_association resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_eip_association` InSpec audit resource to test properties of the singular resource of AWS Elastic IP association.

An Elastic IP (EIP) is uniquely identified by the public IPv4 address, for example `association_id`.

`association_id` _(required)_

The association ID for the address.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Elastic IP association](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-eip-association.html).

## Syntax

### Verify that the association exists

```ruby
describe aws_ec2_eip_association(association_id: 'ASSOCIATION_ID') do
  it { should exist }
end
```

## Parameters

`association_id` _(required)_

: The association ID for the address.

## Properties

`association_id`
: The association ID for the address.

## Examples

**Check association ID whether it is correct or not.**

```ruby
describe aws_ec2_eip_association(association_id: 'ASSOCIATION_ID') do
   its('ASSOCIATION_ID') { should eq "ASSOCIATION_ID" }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_eip_association(association_id: 'ASSOCIATION_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ec2_eip_association(association_id: 'ASSOCIATION_ID') do
  it { should_not exist }
end
```

### be_available

Check if the entity is available.

```ruby
describe aws_ec2_eip_association(association_id: 'ASSOCIATION_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeAddressesResult" %}}

See the [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html) documentation for additional information.
