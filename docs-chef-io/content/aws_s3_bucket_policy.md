+++
title = "aws_s3_bucket_policy resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_s3_bucket_policy"
identifier = "inspec/resources/aws/aws_s3_bucket_policy resource"
parent = "inspec/resources/aws"
+++

Use the `aws_s3_bucket_policy` Chef InSpec audit resource to test properties of a single AWS S3 bucket policy.

The `AWS::S3::BucketPolicy` resource type applies an Amazon S3 bucket policy to an Amazon S3 bucket.

For additional information, including details on parameters and properties, see the [AWS documentation on the `AWS::S3::BucketPolicy` resource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-s3-policy.html).

## Syntax

Ensure that an S3 bucket policy exists.

```ruby
describe aws_s3_bucket_policy(bucket: 'BUCKET_NAME') do
  it { should exist }
end
```

## Parameters

`bucket` _(required)_

: The name of the Amazon S3 bucket to which the policy applies.

## Properties

`Effect`
: The effect of the policy.

`Sid`
: The policy statement ID of the S3 bucket.

`Condition`
: The policy condition key of the S3 bucket.

`Action`
: The policy action of the S3 bucket.

`Resource`
: The policy resource type of the S3 bucket.

`Principal`
: The policy principal of the S3 bucket.

## Examples

Ensure a policy is available:

```ruby
describe aws_s3_bucket_policy(bucket: 'BUCKET_NAME') do
  its('Sid') { should eq 'SID' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_s3_bucket_policy(bucket: 'BUCKET_NAME') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_s3_bucket_policy(bucket: 'BUCKET_NAME') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_s3_bucket_policy(bucket: 'BUCKET_NAME') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="S3:Client:GetBucketPolicyOutput" %}}
