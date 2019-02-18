---
title: About the aws_s3_bucket_object Resource
---

# aws\_s3\_bucket\_object

Use the `aws_s3_bucket_object` InSpec audit resource to test properties of a single AWS bucket object.

Each S3 Object has a 'key' which can be thought of as the name of the S3 Object which uniquely identifies it.


<br>

## Limitations

S3 object security is a complex matter.  For details on how AWS evaluates requests for access, please see [the AWS documentation](https://docs.aws.amazon.com/AmazonS3/latest/dev/how-s3-evaluates-access-control.html).  S3 buckets and the objects they contain support three different types of access control: bucket ACLs, bucket policies, and object ACLs.

As of January 2018, this resource supports evaluating S3 Object ACLs. In particular, users of the `be_public` matcher should carefully examine the conditions under which the matcher will detect an insecure bucket.  See the `be_public` section under the Matchers section below.

## Syntax

An `aws_s3_bucket_object` resource block declares a bucket and an object key by name, and then lists tests to be performed.

    describe aws_s3_bucket_object(bucket_name: 'test_bucket', key: 'test_object_key') do
      it { should exist }
      it { should_not be_public }
    end

<br>

## Examples

The following examples show how to use this InSpec audit resource.

### Test a object's object-level ACL

    describe aws_s3_bucket_object(bucket_name: 'test_bucket', key: 'test_key') do
      its('object_acl.count') { should eq 1 }
    end

### Check to see if a object appears to be exposed to the public

    # See Limitations section above
    describe aws_s3_bucket_object(bucket_name: 'test_bucket', key: 'test_key') do
      it { should_not be_public }
    end
<br>

## Unsupported Properties

### object\_acl

The `object_acl` property is a low-level property that lists the individual Object ACL grants that are in effect on the object.  Other higher-level properties, such as be\_public, are more concise and easier to use.  You can use the `object_acl` property to investigate which grants are in effect, causing be\_public to fail.

The value of object_acl is an Array of simple objects.  Each object has a `permission` property and a `grantee` property.  The `permission` property will be a string such as 'READ', 'WRITE' etc (See the [AWS documentation](https://docs.aws.amazon.com/sdkforruby/api/Aws/S3/Client.html#get_bucket_acl-instance_method) for a full list).  The `grantee` property contains sub-properties, such as `type` and `uri`.


    object_acl = aws_s3_bucket_object(bucket_name: 'my_bucket', key: 'object_key')

    # Look for grants to "AllUsers" (that is, the public)
    all_users_grants = object_acl.select do |g|
      g.grantee.type == 'Group' && g.grantee.uri =~ /AllUsers/
    end

    # Look for grants to "AuthenticatedUsers" (that is, any authenticated AWS user - nearly public)
    auth_grants = object_acl.select do |g|
      g.grantee.type == 'Group' && g.grantee.uri =~ /AuthenticatedUsers/
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers (such as `exist`) please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### be\_public

The `be_public` matcher tests if the object has potentially insecure access controls. This high-level matcher detects several insecure conditions, which may be enhanced in the future. Currently, the matcher reports an insecure object if any of the following conditions are met:

  1. A object ACL grant exists for the 'AllUsers' group
  2. A object ACL grant exists for the 'AuthenticatedUsers' group

Note: This resource does not detect insecure bucket ACLs.

    it { should_not be_public }

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `s3:GetObject`, and `s3:GetObjectAcl` actions set to allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon S3](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazons3.html).
