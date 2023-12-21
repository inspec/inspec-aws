+++
title = "aws_network_manager_global_network Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_network_manager_global_network"
identifier = "inspec/resources/aws/aws_network_manager_global_network Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_network_manager_global_network` InSpec audit resource to test properties of a specific AWS Network Manager global network.

The `AWS::NetworkManager::GlobalNetwork` resource describes one or more global networks.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Network Manager Global Network](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkmanager-globalnetwork.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that Global Network ID exists.

```ruby
describe aws_network_manager_global_network(global_network_id: 'GLOBAL_NETWORK_ID') do
  it { should exist }
end
```

## Parameters

`global_network_id` _(required)_

: The ID of the global network.

## Properties

`global_network_id`
: The ID of the global network.

`global_network_arn`
: The Amazon Resource Name (ARN) of the global network.

`description`
: The description of the global network.

`created_at`
: The date and time that the global network was created.

`state`
: The state of the global network.

`tags`
: The tags for the global network.

## Examples

**Ensure a global network ID is available.**

```ruby
describe aws_network_manager_global_network(global_network_id: 'GLOBAL_NETWORK_ID') do
  its('global_network_id') { should eq 'GLOBAL_NETWORK_ID' }
end
```

**Ensure that the state is `AVAILABLE`.**

```ruby
describe aws_network_manager_global_network(global_network_id: 'GLOBAL_NETWORK_ID') do
    its('state') { should eq 'AVAILABLE' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_network_manager_global_network(global_network_id: 'GLOBAL_NETWORK_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_network_manager_global_network(global_network_id: 'GLOBAL_NETWORK_ID') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_network_manager_global_network(global_network_id: 'GLOBAL_NETWORK_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="NetworkManager:Client:DescribeGlobalNetworksResponse" %}}
