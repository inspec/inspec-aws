---
title: About the aws_redshift_cluster Resource
platform: aws
---

# aws\_redshift\_cluster

Use the `aws_redshift_cluster` InSpec audit resource to test detailed properties of an individual Amazon Redshift cluster.


## Syntax

An `aws_redshift_cluster` resource block uses resource parameters to search for a Redshift cluster, and then tests that Redshift cluster.  If no Redshift clusters match, no error is raised, but the `exists` matcher will return `false` and all properties will be `nil`.  If more than one Redshift cluster matches (due to vague search parameters), an error is raised.

    describe aws_redshift_cluster('test-cluster-id') do
      it { should exist }
    end

    # Can also use hash syntax
    describe aws_redshift_cluster(cluster_identifier: 'test-cluster-id') do
      it { should exist }
    end

### Parameters

#### cluster\_identifier _(required)_

This resource accepts a single parameter, the user-supplied cluster identifier. This parameter isn't case-sensitive.
This can be passed either as a string or as a `cluster_identifier: 'value'` key-value entry in a hash.

Also see the [AWS Redshift cluster documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-redshift-cluster.html).

## Properties

For a comprehensive list of properties available to test on an Redshift cluster, see the [AWS Response Object](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/Redshift/Client.html#describe_clusters-instance_method).

## Examples

### Test the engine used with a Redshift cluster

    describe aws_redshift_cluster(cluster_identifier: 'awsRedshift123') do
      its('engine')         { should eq 'mysql' }
      its('engine_version') { should eq '5.6.37' }
    end

### Test the storage allocated to a Redshift cluster

    describe aws_redshift_cluster(cluster_identifier: 'awsRedshift123') do
      its('encrypted') { should eq true }
      its('allow_version_upgrade') { should eq true }
    end

### Test the cluster status and master username

    describe aws_redshift_cluster(cluster_identifier: 'awsRedshift123') do
      its('master_username') { should eq 'db-maintain' }
      its('cluster_status') { should eq 'available' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

    describe aws_redshift_cluster(cluster_identifier: 'AnExistingRedshift') do
      it { should exist }
    end

    describe aws_redshift_cluster(cluster_identifier: 'ANonExistentRedshift') do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `Redshift:DescribeClusters` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon Redshift](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonRedshift.html).
