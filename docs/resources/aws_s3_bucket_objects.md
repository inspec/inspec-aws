---
title: About the aws_s3_bucket_objects Resource
platform: aws
---

# aws\_s3\_bucket\_objects

Use the `aws_s3_bucket_objects` InSpec audit resource to test properties of multiple AWS S3 bucket objects.

Amazon S3 is an object store that uses unique key-values to store as many objects as you want.

## Syntax

Ensure that a bucket exists.

    describe aws_s3_bucket_objects(bucket_name: 'BUCKET_NAME') do
      it { should exist }
    end

## Parameters

`bucket_name` _(required)_

The bucket name.

See the [AWS documentation on S3 Buckets](https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingBucket.html) for additional information.

## Properties

| Property | Description | Fields |
| --- | --- | --- |
| contents | A list of the metadata about each object returned.| contents |
| contents_keys | A list of the object names. | contents (key) |
| contents_last_modified |  A list of creation date of the objects. | contents (last_modified) |
| contents_sizes | A list of the sizes of the objects in bytes. | contents (size) |
| contents_etags | A list of the entity tags which are a hash of the objects. | contents (etag) |
| contents_storage_classes | A list of the classes of storage used to store the objects. | contents (storage_class) |
| contents_owners | A list of the owners of the objects. | contents (owners) |
| names | The bucket name. | name |
| prefixes | A list of keys that begin with the indicated prefix. | prefix |
| delimiters | A list of delimiters, which are a character used to group keys. | delimiter |
| max_keys | The maximum number of keys returned in the response. By default the action returns up to 1,000 key names. | max_keys |
| common_prefixes | A list of containers for the specified common prefix. | common_prefixes (prefix) |
| encoding_types | A list of the encoding types used by Amazon S3 to encode object key names in the XML response. | encoding_type |
| key_counts | The number of keys returned with this request. | key_count |

## Examples

### Ensure whether the bucket is truncated.

    describe aws_s3_bucket_objects(bucket_name: 'BUCKET_NAME') do
      its ('is_truncated') { should include true }
    end

### Verify the bucket name.

    describe aws_s3_bucket_objects(bucket_name: 'BUCKET_NAME') do
      its ('names') { should include "BUCKET_NAME" }
    end

### Ensure an object name exists.

    describe aws_s3_bucket_objects(bucket_name: 'BUCKET_NAME') do
        its('contents_keys') { should include 'OBJECT_NAME' }
    end

### Ensure an object has a last modified date.

    describe aws_s3_bucket_objects(bucket_name: 'BUCKET_NAME') do
        its('contents_last_modified') { should include  Time.parse("2021-05-05 06:22:04.000000000 +0000") }
    end

### Ensure a storage class of an object exists.

    describe aws_s3_bucket_objects(bucket_name: 'BUCKET_NAME') do
        its('contents_storage_classes') { should include "STANDARD") }
    end

### Verify the key counts of a bucket.

    describe aws_s3_bucket_objects(bucket_name: 'BUCKET_NAME') do
        its('key_counts') { should include 2 }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_s3_bucket_objects(bucket_name: 'BUCKET_NAME') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_s3_bucket_objects(bucket_name: 'BUCKET_NAME') do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `S3:Client:ListObjectsV2Output` action with `Effect` set to `Allow`.