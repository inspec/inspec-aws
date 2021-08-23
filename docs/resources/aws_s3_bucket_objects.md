---
title: About the aws_s3_bucket_objects Resource
platform: aws
---

# aws\_s3\_bucket\_objects

Use the `aws_s3_bucket_objects` InSpec audit resource to test properties of a plural AWS S3 Bucket Objects.

Amazon S3 is an object store that uses unique key-values to store as many objects as you want.

## Syntax

Ensure that a bucket exists.

    describe aws_s3_bucket_objects(bucket_name: 'test_bucket_name') do
      it { should exist }
    end

## Parameters

`bucket_name` _(required)_

| Property | Description | Fields |
| --- | --- | --- |
| bucket_name | The bucket name. | bucket |


See also the [AWS documentation on S3 Buckets](https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingBucket.html).

## Properties

| Property | Description | Fields |
| --- | --- | --- |
| is_truncated | Set to false if all of the results were returned. Set to true if more keys are available to return. If the number of results exceeds that specified by MaxKeys, all of the results might not be returned. | is_truncated |
| contents | Metadata about each object returned.| contents |
| contents_keys | The name that you assign to an object. | contents (key) |
| contents_last_modified | Creation date of the object. | contents (last_modified) |
| contents_etags | The entity tag is a hash of the object. | contents (etag) |
| contents_sizes | The size in bytes of the object. | contents (size) |
| contents_storage_classes | The class of storage used to store the object. | contents (storage_class) |
| contents_owners | The owner of the object. | contents (owners) |
| names | The bucket name. | name |
| prefixes | Keys that begin with the indicated prefix. | prefix |
| delimiters | A delimiter is a character you use to group keys. | delimiter |
| max_keys | Sets the maximum number of keys returned in the response. By default the action returns up to 1,000 key names. | max_keys |
| common_prefixes | Container for the specified common prefix. | common_prefixes (prefix) |
| encoding_types | Encoding type used by Amazon S3 to encode object key names in the XML response. | encoding_type |
| key_counts | KeyCount is the number of keys returned with this request. | key_count |
| continuation_tokens | If ContinuationToken was sent with the request, it is included in the response. | continuation_token |
| next_continuation_tokens | The next continuation token. NextContinuationToken is sent when isTruncated is true, which means there are more keys in the bucket that can be listed. The next list requests to Amazon S3 can be continued with this NextContinuationToken . NextContinuationToken is obfuscated and is not a real key. | next_continuation_token |
| start_after | If StartAfter was sent with the request, it is included in the response. | start_after |

## Examples

### Ensure whether the bucket is truncated.
    describe aws_s3_bucket_objects(bucket_name: 'test_bucket_name') do
      its ('is_truncated') { should include true }
    end

### Verify the bucket name.
    describe aws_s3_bucket_objects(bucket_name: 'test_bucket_name') do
      its ('names') { should include "test_bucket_name" }
    end

### Ensure a object name is available.
    describe aws_s3_bucket_objects(bucket_name: 'test_bucket_name') do
        its('contents_keys') { should include 'test_object_name' }
    end

### Ensure a last modified of an object exist.
    describe aws_s3_bucket_objects(bucket_name: 'test_bucket_name') do
        its('contents_last_modified') { should include  Time.parse("2021-05-05 06:22:04.000000000 +0000") }
    end

### Ensure a storage class of an object exist.
    describe aws_s3_bucket_objects(bucket_name: 'test_bucket_name') do
        its('contents_storage_classes') { should include "STANDARD") }
    end

### Verify the key counts of a bucket.
    describe aws_s3_bucket_objects(bucket_name: 'test_bucket_name') do
        its('key_counts') { should include 2 }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_s3_bucket_objects(bucket_name: 'test_bucket_name') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_s3_bucket_objects(bucket_name: 'dummy') do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `s3:client:list_objects_v2` action with `Effect` set to `Allow`.