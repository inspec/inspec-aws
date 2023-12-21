+++
title = "aws_ram_resource_share Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_ram_resource_share"
identifier = "inspec/resources/aws/aws_ram_resource_share Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ram_resource_share` InSpec audit resource to test properties of a single specific AWS RAM resource share.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS RAM Resource Share](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ram-resourceshare.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that a resource exists.

```ruby
describe aws_ram_resource_share(resource_owner: 'SELF', resource_share_arn: 'RESOURCE_SHARE_ARN') do
  it { should exist }
end
```

## Parameters

`resource_owner` _(required)_

: The type of owner. Possible values: `SELF` and `OTHER-ACCOUNTS`.

`resource_share_arn` _(required)_

: The Amazon Resource Name (ARN) of the resource share.

## Properties

`resource_share_arn`
: The Amazon Resource Name (ARN) of the resource share.

`name`
: The name of the resource share.

`owning_account_id`
: The ID of the AWS account that owns the resource share.

`allow_external_principals`
: Indicates whether principals outside your AWS organization can be associated with a resource share.

`status`
: The status of the resource share.

`status_message`
: A message about the status of the resource share.

`tags`
: The tags for the resource share.

`creation_time`
: The time when the resource share was created.

`last_updated_time`
: The time when the resource share was last updated.

`feature_set`
: Indicates how the resource share was created. Possible values include `CREATED_FROM_POLICY`, `PROMOTING_TO_STANDARD`, and `STANDARD`.

## Examples

**Ensure a resource share ARN is available.**

```ruby
describe aws_ram_resource_share(resource_owner: 'SELF', resource_share_arn: 'RESOURCE_SHARE_ARN') do
  its('resource_share_arn') { should eq 'RESOURCE_SHARE_ARN' }
end
```

**Ensure a resource name is available.**

```ruby
describe aws_ram_resource_share(resource_owner: 'SELF', resource_share_arn: 'RESOURCE_SHARE_ARN') do
    its('name') { should eq 'RESOURCE_SHARE_NAME' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ram_resource_share(resource_owner: 'SELF', resource_share_arn: 'RESOURCE_SHARE_ARN') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ram_resource_share(resource_owner: 'SELF', resource_share_arn: 'RESOURCE_SHARE_ARN') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the work_group name is available.

```ruby
describe aws_ram_resource_share(resource_owner: 'SELF', resource_share_arn: 'RESOURCE_SHARE_ARN') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="RAM:Client:GetResourceSharesResponse" %}}
