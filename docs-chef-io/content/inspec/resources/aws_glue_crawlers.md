+++
title = "aws_glue_crawlers Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_glue_crawlers"
identifier = "inspec/resources/aws/aws_glue_crawlers Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_glue_crawlers` InSpec audit resource to test properties of a plural Glue Crawlers.

The AWS::Glue::Crawler resource specifies an AWS Glue crawler.

For additional information, including details on parameters and properties, see the [AWS documentation on Glue Crawler](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-glue-crawler.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that a crawler exists.

```ruby
describe aws_glue_crawlers do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`names`
: The name of a crawler.

`roles`
: The ARNs of IAM roles used to access customer resources, such as Amazon Simple Storage Service (Amazon S3) data.

`targets`
: A collection of targets to crawl.

`database_names`
: The name of the database in which a crawler's output is stored.

`descriptions`
: A description of a crawler.

`classifiers`
: A list of UTF-8 strings that specify the custom classifiers that are associated with a crawler.

`recrawl_policies`
: A policy that specifies whether to crawl the entire dataset again, or to crawl only folders that were added since the last crawler run.

`schema_change_policies`
: The policy that specifies update and delete behaviors for a crawler.

`lineage_configurations`
: A configuration that specifies whether data lineage is enabled for a crawler.

`states`
: Whether a crawler is running, or whether a run is pending.

`table_prefixes`
: The prefix added to the names of tables that are created.

`schedules`
: The schedule of a crawler.

`crawl_elapsed_times`
: If a crawler is running, contains the total time elapsed since the last crawl began.

`creation_times`
: The time that a crawler was created.

`last_updated`
: The time that a crawler was last updated.

`last_crawls`
: The status of the last crawl, and potentially error information if an error occurred.

`versions`
: The version of a crawler.

`configurations`
: Crawler configuration information. This versioned JSON string allows users to specify aspects of a crawler's behavior.

`crawler_security_configurations`
: The name of the `SecurityConfiguration` structure to be used by a crawler.

## Examples

**Ensure a crawler name is available.**

```ruby
describe aws_glue_crawlers do
  its('names') { should include 'CRAWLER_NAME' }
end
```

**Ensure a database name is available.**

```ruby
describe aws_glue_crawlers do
  its('database_names') { should include 'CRAWLER_DATABASE_NAME' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_glue_crawlers do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_glue_crawlers do
  it { should_not exist }
end
```

### be_available

Use `should` to check if a crawler name is available.

```ruby
describe aws_glue_crawlers do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:GetCrawlersResponse" %}}
