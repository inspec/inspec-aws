---
title: About the aws_s3_buckets Resource
---

# aws\_s3\_buckets

Use the `aws_s3_buckets` InSpec audit resource to list all buckets in a single account.

Use the `aws_s3_bucket` InSpec audit resource to perform in-depth auditing of a single S3 bucket.

<br>

## Syntax

An `aws_s3_buckets` resource block takes no arguments

    describe aws_s3_buckets do
      it { should exist }
    end

<br>

## Examples

The following examples show how to use this InSpec audit resource.

As this is the initial release of `aws_s3_buckets`, its limited functionality precludes examples.

<br>

## Matchers

### exists

The control will pass if the resource contains at least one bucket.

    # Test if there are any buckets
    describe aws_s3_buckets
      it { should exist }
    end

## Properties

### bucket\_names

Provides an array of strings containing the names of the buckets.

    # Examine what buckets have been created.
    describe aws_s3_buckets do
      its('bucket_names') { should eq ['my_bucket'] }
      # OR
      its('bucket_names') { should include 'my_bucket' }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `s3:ListAllMyBuckets` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon S3](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazons3.html).
