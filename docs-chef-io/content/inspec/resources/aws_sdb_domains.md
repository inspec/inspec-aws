+++
title = "aws_sdb_domains Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_sdb_domains"
identifier = "inspec/resources/aws/aws_sdb_domains Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_sdb_domains` InSpec audit resource to test multiple SimpleDB domain names.

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that a domain exists.

```ruby
describe aws_sdb_domains do
  it { should exist }
end
```

For additional information, see the [AWS documentation on AWS SDB Domains.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-simpledb.html).


## Parameters

This resource does not require any parameters.

## Properties

`domain_names`
: A list of domain names that match the expression.

: **Field**: `domain_names`

## Examples

**Ensure a domain name is available.**

```ruby
describe aws_sdb_domains do
  its('domain_names') { should include 'DOMAIN_NAME')' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_sdb_domains do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_sdb_domains do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="SimpleDB:Client:ListDomainsResult" %}}
