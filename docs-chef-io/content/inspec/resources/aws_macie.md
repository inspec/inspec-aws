+++
title = "aws_macie Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_macie"
identifier = "inspec/resources/aws/aws_macie Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_macie` InSpec audit resource to query the configuration and findings of Amazon Macie. See the [Amazon Macie API docs](https://docs.aws.amazon.com/macie/latest/APIReference/welcome.html) for details on information available from Macie.

## Installation

{{% inspec_aws_install %}}

## Syntax

An `aws_macie` resource declares the tests for the Amazon Macie instance active for the organization.

```ruby
describe aws_macie do
  it { should be_enabled }
end
```

The `aws_macie` resource has three properties which behave as [Filter Tables](https://github.com/inspec/inspec/blob/main/dev-docs/filtertable-usage.md):
- `jobs`
- `buckets`
- `findings`

```ruby
describe aws_macie.jobs.where(name: "expected-job-name") do
  its('job_status') { should_not cmp "CANCELLED" }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`session`
: Returns the status and configuration settings for an Amazon Macie account.

`jobs`
: Returns a FilterTable of all jobs defined for Amazon Macie. See all columns inside the table in the [AWS docs](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/Macie2/Client.html#list_classification_jobs-instance_method)

`buckets`
: Returns a FilterTable contianing statistical data and other information on all buckets monitored by Amazon Macie. See all columns inside the table in the [AWS docs](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/Macie2/Client.html#describe_buckets-instance_method)

`findings`
: Returns a FilterTable of all findings discovered by Aamzon Macie. See all columns inside the table in the [AWS docs](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/Macie2/Client.html#get_findings-instance_method).

## Examples

**Test if Macie is enabled.**

```ruby
describe aws_macie do
  it { should be_enabled }
end
```

**Test that a given job is active.**

```ruby
describe aws_macie.jobs.where(name: "expected-job-name") do
  its('job_status') { should_not cmp "CANCELLED" }
end
```

**Test that there are no active findings.**

```ruby
describe aws_macie.findings do
  its('count') { should eq 0 }
end
```

**Test that a given S3 bucket is being monitored by Macie.**

```ruby
describe aws_macie do
  it { should be_monitoring("my-sample-s3-name") }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).


### enabled?

```ruby
describe aws_macie do
    it { should be_enabled }
end
```

### monitored?

Tests theat a particular S3 or list of S3 buckets is monitored by Macie's jobs.

```ruby
describe aws_macie do
  it { should be_monitoring(["my-sample-s3-name-1", "my-sample-s3-name-2"]) }
end
```

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need several action permissions to use each feature of the Macie resource. Your role will need:

- the `{{ .Get "macie2:GetFindings" }}` action
- the `{{ .Get "ListClassificationJobs" }}` action
- the `{{ .Get "macie2:DescribeBuckets" }}` action
- the `{{ .Get "macie2:ListFindings" }}` action
- the `{{ .Get "macie2:GetMacieSession" }}` action 

All with `Effect` set to `Allow`.