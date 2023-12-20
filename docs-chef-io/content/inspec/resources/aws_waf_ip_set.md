+++
title = "aws_waf_ip_set resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_waf_ip_set"
identifier = "inspec/resources/aws/aws_waf_ip_set resource"
parent = "inspec/resources/aws"
+++

Use the `aws_waf_ip_set` Chef InSpec audit resource to test the properties of a single AWS Web Application Firewall (WAF) IP set.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS WAF IPSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-ipset.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that IP set exists.

```ruby
describe aws_waf_ip_set(ip_set_id: 'IP_SET_ID') do
  it { should exist }
end
```

## Parameters

`ip_set_id` _(required)_

: The ID for an IP set.

## Properties

`ip_set_id`
: The IPSetId for an IP set.

`name`
: A friendly name or description of the IP set.

`ip_set_descriptors`
: The IP address type (IPV4 or IPV6 ) and the IP address range (in CIDR notation) that web requests originate from.

`ip_set_descriptors_types`
: Specify IPV4 or IPV6.

`ip_set_descriptors_values`
: Specify an IPv4 address by using CIDR notation.

## Examples

**Ensure an IP set is available.**

```ruby
describe aws_waf_ip_set(ip_set_id: 'IP_SET_ID') do
  its('ip_set_id') { should eq 'IP_SET_ID' }
end
```

**Ensure an IP set name is available.**

```ruby
describe aws_waf_ip_set(ip_set_id: 'IP_SET_ID') do
    its('name') { should eq 'IP_SET_NAME' }
end
```

**Ensure an IP set descriptors type is `IPV4`.**

```ruby
describe aws_waf_ip_set(ip_set_id: 'IP_SET_ID') do
    its('ip_set_descriptors_types') { should include 'IPV4' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_waf_ip_set(ip_set_id: 'IP_SET_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_waf_ip_set(ip_set_id: 'IP_SET_ID') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_waf_ip_set(ip_set_id: 'IP_SET_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="WAF:Client:GetIPSetResponse" %}}
