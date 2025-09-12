+++
title = "aws_ram_resource_shares resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ram_resource_shares"
identifier = "inspec/resources/aws/aws_ram_resource_shares resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ram_resource_shares` InSpec audit resource to test properties of multiple AWS RAM resource shares.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS RAM Resource Share](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ram-resourceshare.html).

## Syntax

Ensure that a resource exists.

```ruby
describe aws_ram_resource_shares(resource_owner: 'SELF') do
  it { should exist }
end
```

## Parameters

`resource_owner` _(required)_

: The type of owner. Possible values: `SELF` and `OTHER-ACCOUNTS`.

## Properties

`resource_share_arns`
: The Amazon Resource Name (ARN) of the resource share.

`names`
: The name of the resource share.

`owning_account_ids`
: The ID of the AWS account that owns the resource share.

`allow_external_principals`
: Indicates whether principals outside your AWS organization can be associated with a resource share.

`statuses`
: The status of the resource share.

`status_messages`
: A message about the status of the resource share.

`tags`
: The tags for the resource share.

`creation_times`
: The time when the resource share was created.

`last_updated_times`
: The time when the resource share was last updated.

`feature_sets`
: Indicates how the resource share was created. Possible values include `CREATED_FROM_POLICY`, `PROMOTING_TO_STANDARD`, and `STANDARD`.

## Examples

Ensure a resource ARN is available:

```ruby
describe aws_ram_resource_shares(resource_owner: 'SELF') do
  its('resource_share_arns') { should include 'RESOURCE_SHARE_ARN' }
end
```

Ensure that a resource share has an `ACTIVE` status:

```ruby
describe aws_ram_resource_shares(resource_owner: 'SELF') do
    its('statuses') { should include 'ACTIVE' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ram_resource_shares(resource_owner: 'SELF') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ram_resource_shares(resource_owner: 'dummy') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the resource is available.

```ruby
describe aws_ram_resource_shares(resource_owner: 'SELF') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="RAM:Client:GetResourceSharesResponse" %}}
