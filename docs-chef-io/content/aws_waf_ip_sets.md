+++
title = "aws_waf_ip_sets resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_waf_ip_sets"
identifier = "inspec/resources/aws/aws_waf_ip_sets resource"
parent = "inspec/resources/aws"
+++

Use the `aws_waf_ip_sets` Chef InSpec audit resource to test the properties of multiple AWS Web Application Firewall (WAF) IP sets.

For additional information, including details on parameters and properties, see the [AWS documentation on `AWS::WAF::IPSet` resource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-ipset.html).

## Syntax

Ensure that IP set exists.

```ruby
describe aws_waf_ip_sets do
  it { should exist }
end
```

## Parameters

`ip_set_id` _(required)_

: The ID for an IP set.

## Properties

`ip_set_ids`
: The IPSetId for an IPSet.

: **Field**: `ip_set_id`

`names`
: A friendly name or description of the IPSet.

: **Field**: `name`

## Examples

Ensure an IP set is available:

```ruby
describe aws_waf_ip_sets do
  its('ip_set_ids') { should include 'IP_SET_ID' }
end
```

Ensure an IP set name is available:

```ruby
describe aws_waf_ip_sets do
    its('names') { should include 'IP_SET_NAME' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_waf_ip_sets do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_waf_ip_sets do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="WAF:Client:ListIPSetsResponse" %}}
