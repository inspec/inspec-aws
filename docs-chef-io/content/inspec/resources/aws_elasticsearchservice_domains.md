+++
title = "aws_elasticsearchservice_domains Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_elasticsearchservice_domains"
identifier = "inspec/resources/aws/aws_elasticsearchservice_domains Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_elasticsearchservice_domains` InSpec audit resource to test properties of a plural Elasticsearch Domains.

The AWS::Elasticsearch::Domain resource creates an Amazon Elasticsearch Service (Amazon ES) domain.

For additional information, including details on parameters and properties, see the [AWS documentation on Elasticsearch Domain](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticsearch-domain.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that a domain name exists.

```ruby
describe aws_elasticsearchservice_domains do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`domain_name`
: Specifies the domain name.

## Examples

**Ensure a domain name is available.**

```ruby
describe aws_elasticsearchservice_domains do
  its('domain_name') { should include 'DOMAIN_NAME' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_elasticsearchservice_domains do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_elasticsearchservice_domains do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the work_group name is available.

```ruby
describe aws_elasticsearchservice_domains do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="ElasticsearchService:Client:ListDomainNamesResponse" %}}
