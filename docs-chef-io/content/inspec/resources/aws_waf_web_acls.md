+++
title = "aws_waf_web_acls resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_waf_web_acls"
identifier = "inspec/resources/aws/aws_waf_web_acls resource"
parent = "inspec/resources/aws"
+++

Use the `aws_waf_web_acls` InSpec audit resource to test the properties of multiple of AWS WAF WebACL.

The `AWS::WAFv2::WebACL` AWS resource defines a collection of rules to use to inspect and control web requests.

For additional information, including details on parameters and properties, see the [AWS documentation on the `AWS::WAFv2::WebACL` resource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-webacl.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that web ACL exists.

```ruby
describe aws_waf_web_acls do
  it { should exist }
end
```

## Parameters

No required parameters.

## Properties

`web_acl_ids`
: The unique identifier for the web ACL.

: **Field**: `web_acl_id`

`names`
: The name of the web ACL.

: **Field**: `name`

## Examples

**Ensure a web ACL is available.**

```ruby
describe aws_waf_web_acls do
  its('web_acl_ids') { should include 'WEB_ACL_ID' }
end
```

**Ensure a web ACL name is available..**

```ruby
describe aws_waf_web_acls do
    its('names') { should include 'WEB_ACL_NAME' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_waf_web_acls do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_waf_web_acls do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_waf_web_acls do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="WAF:Client:ListWebACLsResponse" %}}
