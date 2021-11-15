---
title: About the aws_emr_clusters Resource
platform: aws
---

# aws\_emr\_clusters

Use the `aws_emr_clusters` resource to test the configuration of a collection of clusters of AWS Elastic MapReduce Service.

## Syntax
```ruby
describe aws_emr_clusters do
  its('cluster_ids') { should include 'CLUSTER_ID'}
end
```
#### Parameters

This resource does not expect any parameters.

See also the [AWS documentation on EMR Clusters](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-what-is-emr.html).

## Properties

|Property                                | Description|
| ---                                    | --- |
|cluster\_ids                             | The unique identifier of the cluster. |
|cluster\_arns                            | The Amazon Resource Name (ARN) that identifies the cluster. |
|cluster\_names                           | A user-generated string that you use to identify your cluster. |
|state                                   | The current state of the cluster. |

## Examples


##### Ensure there are no Clusters in an undesired state.
```ruby
describe aws_emr_clusters do
  it { should exist }
  its('state') { should_not include 'UNDESIRED_STATE'}
  its('cluster_ids') { should include 'CLUSTER_ID'}
end
```
## Matchers

For a full list of available matchers, please visit our [matchers page](https://docs.chef.io/inspec/matchers/).

#### exist

The control will pass if the describe returns at least one result.

Use `should` to test the entity should exist.
Use `should_not` to test the entity should not exist.
```ruby
describe aws_emr_clusters.where( <property>: <value>) do
  it { should exist }
end
```ruby
describe aws_emr_clusters.where( <property>: <value>) do
  it { should_not exist }
end
```
    
    
## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EMR:Client:DescribeClusterOutput`, `EMR:Client:DescribeSecurityConfigurationOutput` actions set to allow.

You can find detailed documentation at [Amazon EMR IAM Policies, Roles, and Permissions](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-managed-iam-policies.html)
The documentation for EMR actions is at [Policy Structure](https://docs.aws.amazon.com/emr/latest/ManagementGuide/security_iam_id-based-policy-examples.html)
