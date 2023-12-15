+++
title = "aws_iam_access_analyzers Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_iam_access_analyzers"
identifier = "inspec/resources/aws/aws_iam_access_analyzers Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_iam_access_analyzers` InSpec audit resource to verify settings for multiple AWS IAM Access Analyzers.

For additional information, including details on parameters and properties, see the [AWS documentation on Access Analyzers](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-accessanalyzer-analyzer.html).

## Installation

{{% inspec_aws_install %}}

## Syntax

Ensure that an access analyzer (of either `account` or `organization` type) exists.

```ruby
describe aws_iam_access_analyzers do
    it { should exist }
end
```

## Parameters

`type` _(optional)_

: The type of access analyzers to be tested. Must be one of `account` or `organization`. If this parameter is not given, the resource will return data for both types.

## Properties

`analyzer_names`
: List of names of returned analyzers.

`analyzer_types`
: List of types of returned analyzers (`account` or `organization`).

`arns`
: List of ARNs of returned analyzers.

`created_date`
: List of creation dates of returned analyzers.

`last_resource_analyzed`
: List of resources that were most recently analyzed by the returned analyzers.

`last_analyzed_date`
: List of timestamps representing the times at which the returned analyzers last analyzed a resource.

`tags`
: List of hashes of tags for each returned analyzer.

`status`
: List of statuses for the returned analyzers (`Active`, `Disabled`, `Creating`, or `Failed`).

`status_reason`
: List of details about the current status for each returned analyzer.

## Examples

Determine if an access analyzer for the AWS account (as opposed to the entire organization) exists:

```ruby
describe aws_iam_access_analyzers('account') do
    it { should exist }
end

describe aws_iam_access_analyzers(type: 'account') do
    it { should exist }
end
```

## Matchers

{{% inspec_matchers_link %}}

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_iam_access_analyzers
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_iam_access_analyzers
  it { should_not exist }
end
```

## AWS Permissions

TODO
