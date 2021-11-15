---
title: About the aws_emr_cluster Resource
platform: aws
---

# aws\_emr\_cluster

Use the `aws_emr_cluster` InSpec audit resource to test properties of the singular resource of AWS EMR Cluster.

## Syntax

An `aws_emr_cluster` resource block declares the tests for a single AWS EMR Cluster by cluster ID.
```ruby
describe aws_emr_cluser(cluster_id: 'CLUSTER_ID') do
  it { should exist }
end
```
```ruby
describe aws_emr_cluser('CLUSTER_ID') do
  it { should exist }
end
```
#### Parameters

##### cluster\_id _(required)_

This resource requires a single parameter, the EMR Cluster ID.
This can be passed either as a string or as a `cluster_id: 'value'` key-value entry in a hash.

See also the [AWS documentation on AWS EMR Clusters](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticmapreduce-cluster.html).

## Properties

|Property                                | Description|
| ---                                    | --- |
|cluster\_id                             | The unique identifier of the cluster. |
|cluster\_arn                            | The Amazon Resource Name (ARN) that identifies the cluster. |
|cluster\_name                           | A user-generated string that you use to identify your cluster. |
|state                                   | The current state of the cluster. |
|encryption\_at\_rest                    | Specifies whether at-rest encryption is enabled for the culster.|
|encryption\_in\_transit                 | Specifies whether in-transit encryption is enabled for the culster.|
|local\_disk\_encryption                 | Specifies whether local-disk encryption is enabled for the cluster. |

              
## Examples


##### Test that an EMR Cluster does not exist
```ruby
describe aws_emr_cluster(cluster_id: 'INVALID_CLUSTER_ID') do
  it { should_not exist }
end
```
##### Test that an EMR Cluster state is `WAITING`
```ruby
describe aws_emr_cluster('CLUSTER_ID') do
  its ('state') { should eq 'WAITING' }
end
```
##### Test that an EMR Cluster state is `RUNNING`.
```ruby
describe aws_emr_cluster('CLUSTER_ID') do
  its ('state') { should eq 'RUNNING' }
end
##### Test that an EMR Cluster's at-rest encryption is enabled
```ruby
describe aws_emr_cluster('CLUSTER_ID') do
  its ('encryption_at_rest') { should eq true }
end
```
##### Test that an EMR Cluster's in-transit encryption is enabled
```ruby
describe aws_emr_cluster('CLUSTER_ID') do
  its ('encryption_in_transit') { should eq true }
end
```
##### Test that an EMR Cluster's local-disk encryption is enabled
```ruby
describe aws_emr_cluster('CLUSTER_ID') do
  its ('local_disk_encryption') { should eq true }
end
```
## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

#### exist

The control will pass if the describe returns at least one result.

Use `should` to test the entity should not exist.
```ruby
describe aws_emr_cluster('CLUSTER_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity should not exist.
```ruby
describe aws_emr_cluster('cCLUSTER_ID') do
  it { should_not exist }
end
```

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `elasticmapreduce:DescribeCluster`, `elasticmapreduce:DescribeSecurityConfiguration` & `elasticmapreduce:ListClusters` actions set to allow.

