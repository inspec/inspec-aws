---
title: About the aws_sdb_domains Resource
platform: aws
---

# aws_sdb_domains

Use the `aws_sdb_domains` InSpec audit resource to test multiple SimpleDB domain names.

## Syntax

Ensure that a domain exists.

    describe aws_sdb_domains do
      it { should exist }
    end

For additional information, see the [AWS documentation on AWS SDB Domains.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-simpledb.html).


## Parameters

This resource does not require any parameters.

## Properties

| Property | Description | Field |
| --- | --- | --- |
| domain_names | A list of domain names that match the expression. | domain_names |

## Examples

### Ensure a domain name is available.

    describe aws_sdb_domains do
      its('domain_names') { should include 'DOMAIN_NAME')' }
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

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `SimpleDB:Client:ListDomainsResult` action with `Effect` set to `Allow`.
