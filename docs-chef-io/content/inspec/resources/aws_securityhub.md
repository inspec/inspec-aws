+++
title = "aws_securityhub Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_securityhub"
identifier = "inspec/resources/aws/aws_securityhub Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_securityhub` InSpec audit resource to test properties of a single AWS Security Hub.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Security Hub](https://docs.aws.amazon.com/securityhub/1.0/APIReference/API_DescribeHub.html).

## Installation

{{% inspec_aws_install %}}

## Syntax

Ensure that the hub exists.

```ruby
describe aws_securityhub_hub do
  it { should be_subscribed }
end
```

## Parameters

`aws_region` _(required)_

: The region of the Hub resource that was retrieved.

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
describe aws_securityhub do
  it { should exist }
  its('auto_enable_controls') { should eq true }
end
```

**Ensure a hub ARN is available.**

```ruby
describe aws_securityhub_hub do
    it { should be_subscribed }
    its('hub_arn') { should eq 'HUB_ARN' }
end
```

## Matchers

{{% inspec_matchers_link %}}

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

### subscribed

Use `should` to test that security hub is scribed in us-east-1.

```ruby
describe aws_securityhub_hub(aws_region: 'us-east-1' do
  it { should be_subscribed }
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

{{% aws_permissions_principal action="SecurityHub:Client:DescribeHubResponse" %}}
