+++
title = "aws_ssm_associations resource"

draft = false


[menu.aws]
title = "aws_ssm_associations"
identifier = "inspec/resources/aws/aws_ssm_associations resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ssm_associations` InSpec audit resource to test properties of a collection of AWS SSM Associations.

## Syntax

 Ensure you have exactly 3 associations

```ruby
describe aws_ssm_associations do
  its('names.count') { should cmp 3 }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`association_ids`
: Provides the ID of the association.

`association_names`
: Provides the name of the association.

`association_versions`
: Provides the version of the association.

`document_versions`
: Provides the document version used in the association.

`instance_ids`
: Provides the id of the instance.

`last_execution_dates`
: The date on which the association was last run.

`names`
: The name of the Systems Manager document.

`overviews`
: Provides information about the association.

`schedule_expressions`
: A cron expression that specifies a schedule when the association runs.

`targets`
: Provides the instances targeted by the request to create an association.

For a comprehensive list of properties available, see [the API reference documentation](https://docs.aws.amazon.com/systems-manager/latest/APIReference/API_Association.html)

## Examples

Ensure an Association ID of a SSM Association exists:

```ruby
describe aws_ssm_associations do
  its('association_ids') { should include 'association-id' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_ssm_associations.where( <property>: <value> ) do
  it { should exist }
end
```

```ruby
describe aws_ssm_associations.where( <property>: <value> ) do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="SSM:Client:ListAssociationsResult" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon Systems Manager](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_awssystemsmanager.html).
