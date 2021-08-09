---
title: About the aws_ec2_traffic_mirror_filters Resource
platform: aws
---

# aws_\ec2_\traffic_\mirror_\filters

Use the `aws_ec2_traffic_mirror_filters` InSpec audit resource to test properties of a multiple AWS Traffic Mirror Filter.

## Syntax

An `aws_ec2_traffic_mirror_filters` resource block declares the tests for a set of AWS Traffic Mirror Filter by aws_ec2_traffic_mirror_filters_id.

    describe aws_ec2_traffic_mirror_filters do
      it { should exist }
    end

#### Parameters

No required parameters

## Properties

|Property                 | Description|
| ---                     | --- |
|traffic_mirror_filter_ids     | The id of a Traffic mirror filter.|
|descriptions                  | The description of a Traffic mirror filter.|
|tags                         | A list of hashes with each key-value pair corresponding to an Traffic Mirror Filter, e.g, `[{:key=>"Name", :value=>"Testing Box"}, {:key=>"Environment", :value=>"Dev"}]`|

There are also additional properties available. For a comprehensive list, see [the API reference documentation](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_Instance.html)

## Examples

##### Test that EC2 Traffic Mirror filters should exist
    describe aws_ec2_traffic_mirror_filters do
      it { should exist }
    end

##### Test that EC2 Traffic Mirror filter's description is correct
    describe aws_ec2_traffic_mirror_filters do
      its('description') { should include 'test-des' }
    end

##### Test that an EC2 Traffic Mirror has the correct tag
    describe aws_ec2_traffic_mirror_filters do
      its('tags') { should eq 'test-tmf' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_traffic_mirror_filters do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_traffic_mirror_filters do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:describe_traffic_mirror_filters` action with `Effect` set to `Allow`.

See the [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html) documentation for additional information.




