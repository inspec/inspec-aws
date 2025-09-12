+++
title = "aws_internet_gateway resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_internet_gateway"
identifier = "inspec/resources/aws/aws_internet_gateway resource"
parent = "inspec/resources/aws"
+++

Use the `aws_internet_gateway` InSpec audit resource to test the properties of a single AWS internet gateway.

## Syntax

An `aws_internet_gateway` resource block declares the tests for a single AWS internet gateway by id or name.

```ruby
describe aws_internet_gateway(id: 'igw-abc0123456789deff') do
  it { should exist }
end 
```

```ruby
describe aws_internet_gateway(name: 'my-igw') do
  it { should exist }
end
```

## Parameters

Either the id or the name must be provided.

`id` _(required if `name` not provided)_

: The value of the `internet_gateway_id` assigned by the AWS after the resource has been created.
  This should be in the format of `igw-` followed by 8 or 17 hexadecimal characters and passed as an `id: 'value'` key-value entry in a hash.

`name` _(required if `id` not provided)_

: If a `Name` tag is applied to the internet gateway, this can be used to lookup the resource.
  This must be passed as a `name: 'value'` key-value entry in a hash.
  If there are multiple internet gateways with the same name, this resource will raise an error.

## Properties

`id`
: The ID of the internet gateway.

`name`
: The value of the `Name` tag. It is `nil` if not defined.

`vpc_id`
: The ID of the attached VPC. It is `nil` if the resource is in a `detached` state.

`tags`
: A hash, with each key-value pair corresponding to an internet gateway tag.

`attached?`
: Indicates whether the internet gateway is **attached** to a VPC or not (`true` or `false`).

`detached?`
: Indicates whether the internet gateway is in a **detached** state or not (`true` or `false`).

`owner_id`
: The ID of the AWS account that owns the internet gateway.

There are also additional properties available. For a comprehensive list, see [the API reference documentation](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_InternetGateway.html)

## Examples

Test that the internet gateway is attached:

```ruby
describe aws_internet_gateway(name: 'my-igw') do
  it { should be_attached }
end
```

Test that the ID of the attached VPC is `vpc-1234567890abcdef1`:

```ruby
describe aws_internet_gateway(id: 'igw-abc0123456789deff') do
  its('vpc_id') { should eq `vpc-1234567890abcdef1` }
end
```

Test that the internet gateway has a certain tag:

```ruby
describe aws_internet_gateway(name: 'my-igw') do
  its('tags') { should include('environment' => 'dev') }
Regardless of the value:

end
```

## Matchers

This InSpec audit resource has the following special matcher. For a full list of available matchers, visit the [InSpec matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

```ruby
describe aws_internet_gateway(name: 'my-igw') do
    it { should exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeInternetGatewaysResult" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
