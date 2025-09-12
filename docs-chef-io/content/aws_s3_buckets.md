+++
title = "aws_s3_buckets resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_s3_buckets"
identifier = "inspec/resources/aws/aws_s3_buckets resource"
parent = "inspec/resources/aws"
+++

Use the `aws_s3_buckets` InSpec audit resource to list all buckets in a single account.

For additional information, including details on parameters and properties, see the [AWS documentation on S3 Buckets](https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingBucket.html).

## Syntax

An `aws_s3_buckets` resource block takes no arguments

```ruby
describe aws_s3_buckets do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`bucket_names`
: An Array of bucket names.

`tags`
: An hash with each key-value pair corresponding to a tag associated with the entity.

`entries`
: Provides access to the raw results of the query, which can be treated as an array of hashes.

## Examples

**Examine what buckets have been created.**

```ruby
describe aws_s3_buckets do
  its('bucket_names') { should eq ['my_bucket'] }
**OR.**

  its('bucket_names') { should include 'my_bucket' }
end
```

**Check the tags on buckets                .**

```ruby
describe aws_s3_buckets.where( bucket_names: 'my-bucket' ) do
    its('tags') { should include(:Environment => 'env-name',
                                 :Name => 'bucket-name')}
end
```

## Matchers

### exist

The control will pass if the resource contains at least one bucket.

    # Test if there are any buckets

```ruby
describe aws_s3_buckets
  it { should exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="S3:Client:ListBucketsOutput" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon S3](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazons3.html).
