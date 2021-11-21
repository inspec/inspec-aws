---
title: About the aws_elasticsearchservice_domains Resource
platform: aws
---

# aws\_elasticsearchservice\_domains

Use the `aws_elasticsearchservice_domains` InSpec audit resource to test properties of a plural Elasticsearch Domains.

The AWS::Elasticsearch::Domain resource creates an Amazon Elasticsearch Service (Amazon ES) domain.

## Syntax

Ensure that a domain name exists.

    describe aws_elasticsearchservice_domains do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on Elasticsearch Domain](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticsearch-domain.html).

## Properties

| Property | Description|
| --- | --- |
| domain_name | Specifies the domain name. |

## Examples

### Ensure a domain name is available.

    describe aws_elasticsearchservice_domains do
      its('domain_name') { should include 'DOMAIN_NAME' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_elasticsearchservice_domains do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.
      
    describe aws_elasticsearchservice_domains do
      it { should_not exist }
    end

### be_available

Use `should` to check if the work_group name is available.

    describe aws_elasticsearchservice_domains do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ElasticsearchService:Client:ListDomainNamesResponse` action with `Effect` set to `Allow`.
