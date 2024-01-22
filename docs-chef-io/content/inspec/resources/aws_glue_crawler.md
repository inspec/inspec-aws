+++
title = "aws_glue_crawler Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_glue_crawler"
identifier = "inspec/resources/aws/aws_glue_crawler Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_glue_crawler` InSpec audit resource to test properties of a single AWS Glue crawler.

The AWS::Glue::Crawler resource specifies an AWS Glue crawler.

For additional information, including details on parameters and properties, see the [AWS documentation on Glue Crawler](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-glue-crawler.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that a crawler name exists.

```ruby
describe aws_glue_crawler(name: 'CRAWLER_NAME') do
  it { should exist }
end
```

## Parameters

`name` _(required)_

: The name of the crawler.

## Properties

`name`
: The name of the crawler.

`role`
: The ARN of an IAM role that's used to access customer resources, such as Amazon Simple Storage Service (Amazon S3) data.

`target`
: A collection of targets to crawl.

`database_name`
: The name of the database in which the crawler's output is stored.

`description`
: A description of the crawler.

`classifier`
: A list of UTF-8 strings that specify the custom classifiers that are associated with the crawler.

`recrawl_policy`
: A policy that specifies whether to crawl the entire dataset again, or to crawl only folders that were added since the last crawler run.

`schema_change_policy`
: The policy that specifies update and delete behaviors for the crawler.

`lineage_configuration`
: A configuration that specifies whether data lineage is enabled for the crawler.

`state`
: Whether the crawler is running, or whether a run is pending.

`table_prefix`
: The prefix added to the names of tables that are created.

`schedule`
: For scheduled crawlers, the schedule when the crawler runs.

`crawl_elapsed_time`
: If the crawler is running, contains the total time elapsed since the last crawl began.

`creation_time`
: The time that the crawler was created.

`last_updated`
: The time that the crawler was last updated.

`last_crawl`
: The status of the last crawl, and potentially error information if an error occurred.

`version`
: The version of the crawler.

`configuration`
: Crawler configuration information. This versioned JSON string allows users to specify aspects of a crawler's behavior.

`crawler_security_configuration`
: The name of the `SecurityConfiguration` structure to be used by this crawler.

## Examples

**Ensure a crawler name is available.**

```ruby
describe aws_glue_crawler(name: 'CRAWLER_NAME') do
  its('name') { should eq 'CRAWLER_NAME' }
end
```

**Verify the database name in the crawler.**

```ruby
describe aws_glue_crawler(name: 'CRAWLER_NAME') do
    its('database_name') { should eq 'CRAWLER_DATABASE_NAME' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_glue_crawler(name: 'crawler_name') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_glue_crawler(name: 'dummy') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the work_group name is available.

```ruby
describe aws_glue_crawler(name: 'crawler_name') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:GetCrawlerResponse" %}}
