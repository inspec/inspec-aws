+++
title = "aws_ssm_association resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ssm_association"
identifier = "inspec/resources/aws/aws_ssm_association resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ssm_association` InSpec audit resource to test properties of a ssm association.

For additional information, including details on parameters and properties, see the [AWS documentation on SSM Associations](https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-state-assoc.html).

## Syntax

 An `aws_ssm_association` resource block uses the parameter to select a ssm association.

```ruby
describe aws_ssm_association(association_id: 'association-id-1234') do
  it { should exist }
end
```

```ruby
describe aws_ssm_association(name: 'document-name', instance_id: 'instance-id') do
  it { should exist }
end
```

## Parameters

`association_id` _OR_ name _AND_ instance_id _(name and instance_id are required together)_

: This resource accepts the association_id, document name and instance id. If not using association_id, name and instance id must both be provided as parameters
  This can be passed either as a string or as a `association_id: 'value'` key-value entry in a hash.

## Properties

`name`
: The name of the Systems Manager document.

`instance_id`
: Provides the id of the instance.

`association_version`
: Provides the version of the association.

`date`
: The date when the association was made.

`last_update_association_date`
: The date when the association was last updated.

`status`
: The association status.

`overview`
: Provides information about the association.

`document_version`
: Provides the document version used in the association.

`automation_target_parameter_name`
: Specify the target for the association. This target is required for associations that use an Automation document and target resources by using rate controls.

`parameters`
: A description of the parameters for a document.

`association_id`
: Provides the ID of the association.

`targets`
: Provides the instances targeted by the request to create an association.

`schedule_expression`
: A cron expression that specifies a schedule when the association runs.

`output_location`
: An S3 bucket where you want to store the output details of the request.

`last_execution_date`
: The date on which the association was last run.

`last_successful_execution_date`
: The last date on which the association was successfully run.

`association_name`
: Provides the name of the association.

`max_errors`
: The number of errors that are allowed before the system stops sending requests to run the association on additional targets.

`max_concurrency`
: The maximum number of targets allowed to run the association at the same time.

`compliance_severity`
: The severity level that is assigned to the association.

`sync_compliance`
: The mode for generating association compliance. You can specify AUTO or MANUAL.

`apply_only_at_cron_interval`
: By default, when you create a new associations, the system runs it immediately after it is created and then according to the schedule you specified. Specify this option if you don't want an association to run immediately after you create it.

For a comprehensive list of properties available, see [the API reference documentation](https://docs.aws.amazon.com/systems-manager/latest/APIReference/API_Association.html)

## Examples

Check the Name of a SSM Association:

```ruby
describe aws_ssm_association(association_id: 'association-id-1234') do
  its('name')  { should eq 'association-name-1234' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_ssm_association(association_id: 'association-id-1234') do
  it { should exist }
end
```

```ruby
describe aws_ssm_association(association_id: 'association-id-6789') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="SSM:Client:DescribeAssociationResult" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon Systems Manager](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_awssystemsmanager.html).
