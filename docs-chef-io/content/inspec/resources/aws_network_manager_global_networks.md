+++
title = "aws_network_manager_global_networks Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_network_manager_global_networks"
identifier = "inspec/resources/aws/aws_network_manager_global_networks Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_network_manager_global_networks` InSpec audit resource to test properties of a single specific AWS Network Manager global network.

The `AWS::NetworkManager::GlobalNetwork` resource describes one or more global networks.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Network Manager Global Network](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkmanager-globalnetwork.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that Global Network ID exists.

```ruby
describe aws_network_manager_global_networks do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`global_network_ids`
: global_network_id.

`global_network_arns`
: global_network_arn.

`descriptions`
: description.

`created_at`
: created_at.

`states`
: state.

`tags`
: tags.

## Examples

**Ensure a Global Network ID is available.**

```ruby
describe aws_network_manager_global_networks do
  its('global_network_ids') { should include 'GLOBAL_NETWORK_ID' }
end
```

**Ensure that the state is `AVAILABLE`.**

```ruby
describe aws_network_manager_global_networks do
    its('states') { should include 'AVAILABLE' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_network_manager_global_networks do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_network_manager_global_networks do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="NetworkManager:Client:DescribeGlobalNetworksResponse" %}}
