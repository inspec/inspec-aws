+++
title = "aws_emr_cluster resource"

draft = false


[menu.aws]
title = "aws_emr_cluster"
identifier = "inspec/resources/aws/aws_emr_cluster resource"
parent = "inspec/resources/aws"
+++

Use the `aws_emr_cluster` InSpec audit resource to test properties of the singular resource of AWS EMR cluster.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EMR clusters](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticmapreduce-cluster.html).

## Syntax

An `aws_emr_cluster` resource block declares the tests for a single AWS EMR cluster by cluster ID.

```ruby
describe aws_emr_cluster(cluster_id: 'CLUSTER_ID') do
  it { should exist }
end
```

```ruby
describe aws_emr_cluster('CLUSTER_ID') do
  it { should exist }
end
```

## Parameters

`cluster_id` _(required)_

: This resource requires a single parameter, the EMR cluster ID.
  This can be passed either as a string or as a `cluster_id: 'value'` key-value entry in a hash.

## Properties

`cluster_id`
: The unique identifier of the cluster.

`cluster_arn`
: The Amazon Resource Name (ARN) that identifies the cluster.

`cluster_name`
: A user-generated string that you use to identify your cluster.

`state`
: The current state of the cluster.

`status_state_change_reason_code`
: The programmatic code for the state change reason.

`status_state_change_reason_message`
: The descriptive message for the state change reason.

`status_timeline_creation_date_time`
: The creation date and time of the cluster.

`status_timeline_ready_date_time`
: The date and time when the cluster was ready to run steps.

`status_timeline_end_date_time`
: The date and time when the cluster was terminated.

`applications`
: The name of applications installed on this cluster.

`auto_scaling_role`
: An IAM role for automatic scaling policies.

`custom_ami_id`
: Available only in Amazon EMR version 5.7.0 and later. The ID of a custom Amazon EBS-backed Linux AMI if the cluster uses a custom AMI.

`ebs_root_volume_size`
: The size, in GiB, of the Amazon EBS root device volume of the Linux AMI that is used for each EC2 instance. Available in Amazon EMR version 4.x and later.

`kerberos_attributes_realm`
: The name of the Kerberos realm to which all nodes in a cluster belong.

`kerberos_attributes_realm_ad_domain_join_user`
: A user with sufficient privileges to join resources to the domain. Required only when establishing a cross-realm trust with an Active Directory domain.

`log_encryption_kms_key_id`
: The KMS key used for encrypting log files.

`log_uri`
: The path to the Amazon S3 location where logs for this cluster are stored.

`release_label`
: The Amazon EMR release label, which determines the version of open-source application packages installed on the cluster.

`scale_down_behavior`
: The way that individual Amazon EC2 instances terminate when an automatic scale-in activity occurs or an instance group is resized. Valid values are TERMINATE_AT_INSTANCE_HOUR, TERMINATE_AT_TASK_COMPLETION.

`service_role`
: The IAM role that Amazon EMR assumes in order to access Amazon Web Services resources on your behalf.

`step_concurrency_level`
: Specifies the number of steps that can be executed concurrently.

`visible_to_all_users`
: Indicates whether the cluster is visible to IAM principals in the Amazon Web Services account associated with the cluster.

`managed_scaling_policy_unit_type`
: The unit type used for specifying a managed scaling policy. Valid values are InstanceFleetUnits, Instances, VCPU.

`security_configuration_name`
: The name of the security configuration applied to the cluster.

## Examples

Test that an EMR cluster state is `WAITING`:

```ruby
describe aws_emr_cluster('CLUSTER_ID') do
  its ('state') { should eq 'WAITING' }
end
```

Test that an EMR cluster state is `RUNNING`:

```ruby
describe aws_emr_cluster('CLUSTER_ID') do
  its ('state') { should eq 'RUNNING' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

Use `should` to test an entity that should exist.

```ruby
describe aws_emr_cluster('CLUSTER_ID') do
  it { should exist }
end
```

Use `should_not` to test for an entity that should not exist.

```ruby
describe aws_emr_cluster('CLUSTER_ID') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EMR:Client:DescribeClusterOutput" %}}
