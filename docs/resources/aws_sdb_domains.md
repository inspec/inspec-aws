---
title: About the aws_sdb_domains Resource
platform: aws
---

# aws_sdb_domains

Use the `aws_sdb_domains` InSpec audit resource to get the list of all SDB Domain names.

## Syntax

Ensure that the base path mappings exists.

    describe aws_sdb_domains do
      it { should exist }
    end


For additional information, see the [AWS documentation on AWS SDB Domains.](https://docs.aws.amazon.com/AmazonSimpleDB/latest/DeveloperGuide/Welcome.html).

## Properties

| Property | Description | Field | 
| --- | --- | --- |
| domain_names | Names of the domains. | domain_names |

## Examples

### Ensure a base path is available.
    describe aws_sdb_domains do
      its('domain_names') { should include 'DomainName')' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_sdb_domains do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_sdb_domains do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `APIGateway:Client:DomainsResult` action with `Effect` set to `Allow`.