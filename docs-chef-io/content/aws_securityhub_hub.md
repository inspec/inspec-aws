+++
title = "aws_securityhub_hub resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_securityhub_hub"
identifier = "inspec/resources/aws/aws_securityhub_hub resource"
parent = "inspec/resources/aws"
+++

Use the `aws_securityhub_hub` InSpec audit resource to test properties of a single AWS Security Hub.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Security Hub](https://docs.aws.amazon.com/securityhub/1.0/APIReference/API_DescribeHub.html).

## Syntax

Ensure that the hub exists.

```ruby
describe aws_securityhub_hub(hub_arn: 'HUB_ARN') do
  it { should exist }
end
```

## Parameters

`hub_arn` _(required)_

: The ARN of the Hub resource that was retrieved.

## Properties

`hub_arn`
: The ARN of the Hub resource that was retrieved.

`subscribed_at`
: The date and time when Security Hub was enabled in the account.

`auto_enable_controls`
: Whether to automatically enable new controls when they are added to standards that are enabled.

## Examples

**Ensure an auto enable controls is true.**

```ruby
describe aws_securityhub_hub(hub_arn: 'HUB_ARN') do
  its('auto_enable_controls') { should eq true }
end
```

**Ensure a hub ARN is available.**

```ruby
describe aws_securityhub_hub(hub_arn: 'HUB_ARN') do
    its('hub_arn') { should eq 'HUB_ARN' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_securityhub_hub(hub_arn: 'HUB_ARN') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_securityhub_hub(hub_arn: 'HUB_ARN') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_securityhub_hub(hub_arn: 'HUB_ARN') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="SecurityHub:Client:DescribeHubResponse" %}}
