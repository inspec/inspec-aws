+++
title = "aws_redshift_cluster Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_redshift_cluster"
identifier = "inspec/resources/aws/aws_redshift_cluster Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_redshift_cluster` InSpec audit resource to test detailed properties of an individual AWS Redshift cluster.


## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

An `aws_redshift_cluster` resource block uses resource parameters to search for a Redshift cluster, and then tests that Redshift cluster.  If no Redshift clusters match, no error is raised, but the `exists` matcher will return `false` and all properties will be `nil`.  If more than one Redshift cluster matches (due to vague search parameters), an error is raised.

```ruby
describe aws_redshift_cluster('test-cluster-id') do
  it { should exist }
end
```

    # Can also use hash syntax
```ruby
describe aws_redshift_cluster(cluster_identifier: 'test-cluster-id') do
  it { should exist }
end
```

## Parameters

`cluster_identifier` _(required)_

: This resource accepts a single parameter, the user-supplied cluster identifier. This parameter isn't case-sensitive.
  This can be passed either as a string or as a `cluster_identifier: 'value'` key-value entry in a hash.

: Also see the [AWS Redshift cluster documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-redshift-cluster.html).

## Properties

`cluster_identifier`
: The unique IDs of the redshift clusters returned.

`db_names`
: The name of the database associated with each redshift cluster.

`node_type`
: The redshift instance type.

`cluster_create_time`
: The create time of redshift clusters.

`cluster_subnet_group_name`
: The cluster name of redshift clusters.

`cluster_status`
: The current status of each cluster .

`cluster_availability_status`
: The current status of cluster.

`modify_status`
: The current status of cluster.

`availability_zones`
: A list of availability zones of the redshift clusters returned.

`allow_version_upgrade`
: Returns T/F depending on whether version upgrade is allowed or not.

`encrypted`
: Returns T/F depending on whether Redshift clusters are encrypted or not.

`cluster_subnet_group_name`
: Cluster subnet group name for redshift clusters returned.

`iam_roles`
: iam_roles that are used in the cluster.

`vpc_id`
: vpc_id of the redshift clusters.

## Examples

For a comprehensive list of properties available to test on an Redshift cluster see the [AWS Response Object](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/Redshift/Client.html#describe_clusters-instance_method.html).

## Examples

### Test the engine used with a Redshift cluster

```ruby
describe aws_redshift_cluster(cluster_identifier: 'awsRedshift123') do
  its('engine')         { should eq 'mysql' }
  its('engine_version') { should eq '5.6.37' }
end
```

### Test the encryption and version_upgrade attribute of the Redshift cluster

```ruby
describe aws_redshift_cluster(cluster_identifier: 'awsRedshift123') do
  its('encrypted') { should eq true }
  its('allow_version_upgrade') { should eq true }
end
```

### Test the cluster status and master username

```ruby
describe aws_redshift_cluster(cluster_identifier: 'awsRedshift123') do
  its('master_username') { should eq 'db-maintain' }
  its('cluster_status') { should eq 'available' }
end
```



## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_redshift_cluster(cluster_identifier: 'AnExistingRedshift') do
  it { should exist }
end
```

```ruby
describe aws_redshift_cluster(cluster_identifier: 'ANonExistentRedshift') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="Redshift:Client:ClustersMessage" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon Redshift](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonRedshift.html).
