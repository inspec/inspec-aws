+++
title = "aws_rds_group_options resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_rds_group_options"
identifier = "inspec/resources/aws/aws_rds_group_options resource"
parent = "inspec/resources/aws"
+++

Use the `aws_rds_group_options` InSpec audit resource to test detailed properties of a group of Amazon Relational Database Service (RDS) clusters.

RDS gives you access to the capabilities of a MySQL, MariaDB, PostgreSQL, Microsoft SQL Server, Oracle, or Amazon Aurora database server.

## Syntax

An `aws_rds_group_options` resource block uses resource parameters to search for an RDS option group, and then tests that RDS option group. If no RDS option group match, no error is raised, but the `exists` matcher will return `false` and all properties will be `nil`.
describe aws_rds_group_option(engine_name: 'mysql') do
it { should exist }
end

    # Can also use hash syntax

```ruby
describe aws_rds_group_options do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`option_group_names`
: The name RDS option group.

: **Field**: `option_group_name`

`option_group_description`
: The name of the database associated with each RDS cluster.

: **Field**: `option_group_description`

`engine_names`
: The name of the engine associated with each RDS cluster.

: **Field**: `engine_name`

`major_engine_versions`
: The major engine version of a option group.

: **Field**: `major_engine_version`

`option_group_arns`
: The arn of a option group.

: **Field**: `option_group_arn`

`vpc_ids`
: The vpc id of  option group.

: **Field**: `vpc_id`

`allows_vpc_and_non_vpc_instance_memberships`
: The storage allocated to each cluster.

: **Field**: `allows_vpc_and_non_vpc_instance_memberships`
See the [AWS documentation on RDS cluster](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-optiongroup.html).

For a comprehensive list of properties available to test on an RDS cluster see the [AWS Response Object](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/RDS/DBCluster.html).

## Examples

**Test the engine used with an aws_rds_group_option.**

```ruby
describe aws_rds_group_options do
  its('engine_name')         { should include 'mysql' }
  its('major_engine_version') { should include '5.6.37' }
end
```

**Ensure a specific cluster exists.**

```ruby
describe aws_rds_group_options do
  its('option_group_name') { should include 'option_group_name8-test }
end
```

**Use the InSpec resource to request the IDs of all RDS clusters, then test in-depth using `aws_rds_cluster` to ensure all clusters are encrypted and have a sensible size.**

```ruby
aws_rds_group_options.option_group_name.each do |option_group_name|
    describe  aws_rds_group_option(option_group_name) do
      it { should exist }
  end
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_rds_group_options do
  it { should exist }
end
```

```ruby
describe aws_rds_group_options do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="RDS:Client:OptionGroups" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon RDS](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonrds.html).
