+++
title = "aws_vpc_endpoint_service_permission resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_vpc_endpoint_service_permission"
identifier = "inspec/resources/aws/aws_vpc_endpoint_service_permission resource"
parent = "inspec/resources/aws"
+++

Use the `aws_vpc_endpoint_service_permission` InSpec audit resource to test the properties of a single AWS VPC endpoint service permission.

## Syntax

An `aws_vpc_endpoint_service_permission` resource block declares the tests for a single AWS VPC endpoint service permission by `service_id` and `principal`.

```ruby
describe aws_vpc_endpoint_service_permission(service_id: 'VPC_SERVICE_ID', principal: 'arn:aws:iam::AWS_ACCOUNT_ID:user/USER_NAME') do
  it { should exist }
end
```

## Parameters

The AWS VPC endpoint service ID is required.

`service_id` _(required)_

: The ID of the VPC endpoint service:

: - must contain between 1 and 50 alphanumeric characters or hyphens

- should start with `vpce-svc-`
- cannot end with a hyphen or contain two consecutive hyphens

: For example, `vpce-svc-04deb776dc2b8e67f`.

: It can be passed as a `service_id: 'value'` key-value entry in a hash.

`principal` _(required)_

: The ARN of the principal.
  It can be passed as a `principal: 'value'` key-value entry in a hash.

## Properties

`principal_type`
: The type of principal.

`principal`
: The Amazon Resource Name (ARN) of the principal.

## Examples

**Test that a VPC endpoint service permission is available.**

```ruby
describe aws_vpc_endpoint_service_permission(service_id: 'VPC_SERVICE_ID', principal: 'arn:aws:iam::AWS_ACCOUNT_ID:user/USER_NAME') do
    it { should exist }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

```ruby
describe aws_vpc_endpoint_service_permission(service_id: 'VPC_SERVICE_ID', principal: 'arn:aws:iam::AWS_ACCOUNT_ID:user/USER_NAME') do
    it { should exist }
end
```

### Verify that a principal has a user type

```ruby
describe aws_vpc_endpoint_service_permission(service_id: 'VPC_SERVICE_ID', principal: 'arn:aws:iam::AWS_ACCOUNT_ID:user/USER_NAME') do
    it { should be_principal_type_user }
end
```

### Verify that a principal does not have an all type

```ruby
describe aws_vpc_endpoint_service_permission(service_id: 'VPC_SERVICE_ID', principal: 'arn:aws:iam::AWS_ACCOUNT_ID:user/USER_NAME') do
    it { should_not be_principal_type_all }
end
```

### Verify that a principal does not have an organization unit type

```ruby
describe aws_vpc_endpoint_service_permission(service_id: 'VPC_SERVICE_ID', principal: 'arn:aws:iam::AWS_ACCOUNT_ID:user/USER_NAME') do
    it { should_not be_principal_type_organization_unit }
end
```

### Verify that a principal does not have an account type

```ruby
describe aws_vpc_endpoint_service_permission(service_id: 'VPC_SERVICE_ID', principal: 'arn:aws:iam::AWS_ACCOUNT_ID:user/USER_NAME') do
    it { should_not be_principal_type_account }
end
```

### Verify that a principal does not have a role type

```ruby
describe aws_vpc_endpoint_service_permission(service_id: 'VPC_SERVICE_ID', principal: 'arn:aws:iam::AWS_ACCOUNT_ID:user/USER_NAME') do
    it { should_not be_principal_type_role }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeVpcEndpointServicePermissionsResult" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon VPC endpoint service permissions](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeVpcEndpointServicePermissions.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
