+++
title = "aws_emr_clusters resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_emr_clusters"
identifier = "inspec/resources/aws/aws_emr_clusters resource"
parent = "inspec/resources/aws"
+++

Use the `aws_emr_clusters` resource to test the configuration of a collection of clusters of AWS Elastic MapReduce Service.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EMR clusters](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticmapreduce-cluster.html).

## Syntax

```ruby
describe aws_emr_clusters do
  its('cluster_ids') { should include 'CLUSTER_ID'}
end
```

## Parameters

This resource does not require any parameters.

## Properties

`cluster_ids`
: The unique identifier of the cluster.

: **Field**: `cluster_id`

`cluster_arns`
: The Amazon Resource Name (ARN) that identifies the cluster.

: **Field**: `cluster_arn`

`cluster_names`
: A user-generated string that you use to identify your cluster.

: **Field**: `cluster_name`

`status_states`
: The current state of the cluster.

: **Field**: `status(state)`

`status_state_change_reason_code`
: The programmatic code for the state change reason.

: **Field**: `status(state_change_reason(code))`

`status_state_change_reason_message`
: The descriptive message for the state change reason.

: **Field**: `status(state_change_reason(message))`

`status_timeline_creation_date_time`
: The creation date and time of the cluster.

: **Field**: `status(timeline(creation_date_time))`

`status_timeline_ready_date_time`
: The date and time when the cluster was ready to run steps.

: **Field**: `status(timeline(ready_date_time))`

`status_timeline_end_date_time`
: The date and time when the cluster was terminated.

: **Field**: `status(timeline(end_date_time))`

`applications`
: The name of applications installed on this cluster.

: **Field**: `applications`

`auto_scaling_roles`
: An IAM role for automatic scaling policies.

: **Field**: `auto_scaling_role`

`custom_ami_ids`
: Available only in Amazon EMR version 5.7.0 and later. The ID of a custom Amazon EBS-backed Linux AMI if the cluster uses a custom AMI.

: **Field**: `custom_ami_id`

`ebs_root_volume_sizes`
: The size, in GiB, of the Amazon EBS root device volume of the Linux AMI that is used for each EC2 instance. Available in Amazon EMR version 4.x and later.

: **Field**: `ebs_root_volume_size`

`kerberos_attributes_realms`
: The name of the Kerberos realm to which all nodes in a cluster belong.

: **Field**: `kerberos_attributes(realm)`

`kerberos_attributes_realm_ad_domain_join_user`
: A user with sufficient privileges to join resources to the domain. Required only when establishing a cross-realm trust with an Active Directory domain.

: **Field**: `kerberos_attributes(ad_domain_join_user)`

`log_encryption_kms_key_ids`
: The KMS key used for encrypting log files.

: **Field**: `log_encryption_kms_key_id`

`log_uris`
: The path to the Amazon S3 location where logs for this cluster are stored.

: **Field**: `log_uri`

`release_labels`
: The Amazon EMR release label, which determines the version of open-source application packages installed on the cluster.

: **Field**: `release_label`

`scale_down_behaviors`
: The way that individual Amazon EC2 instances terminate when an automatic scale-in activity occurs or an instance group is resized. Valid values are TERMINATE_AT_INSTANCE_HOUR, TERMINATE_AT_TASK_COMPLETION.

: **Field**: `scale_down_behavior`

`service_roles`
: The IAM role that Amazon EMR assumes in order to access Amazon Web Services resources on your behalf.

: **Field**: `service_role`

`step_concurrency_levels`
: Specifies the number of steps that can be executed concurrently.

: **Field**: `step_concurrency_level`

`visible_to_all_users`
: Indicates whether the cluster is visible to IAM principals in the Amazon Web Services account associated with the cluster.

: **Field**: `visible_to_all_users`

`security_configuration_names`
: The name of the security configuration applied to the cluster.

: **Field**: `security_configuration`

## Examples

Ensure there are no EMR clusters in an undesired state:

```ruby
describe aws_emr_clusters do
  it { should exist }
  its('state') { should_not include 'UNDESIRED_STATE'}
  its('cluster_ids') { should include 'CLUSTER_ID'}
end
```

## Matchers

For a full list of available matchers, visit the [InSpec matchers page](https://docs.chef.io/inspec/matchers/).

### exist

Use `should` to test for an entity that should exist.

```ruby
describe aws_emr_clusters.where( <property>: <value>) do
  it { should exist }
end
```

Use `should_not` to test for an entity that should not exist.

```ruby
describe aws_emr_clusters.where( <property>: <value>) do
  it { should_not exist }
end
```

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EMR:Client:DescribeClusterOutput`, `EMR:Client:ListClustersOutput` actions set to allow.

You can find detailed documentation at [Amazon EMR IAM Policies, Roles, and Permissions](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-managed-iam-policies.html)
The documentation for EMR actions is at [Policy Structure](https://docs.aws.amazon.com/emr/latest/ManagementGuide/security_iam_id-based-policy-examples.html)
