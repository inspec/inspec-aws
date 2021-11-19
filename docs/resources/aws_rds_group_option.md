---
title: About aws_rds_group_option Resource
---

# aws\_rds\_option\_group

Use the `aws_rds_group_option` InSpec audit resource to test detailed properties of an individual RDS cluster.An `aws_rds_group_option` resource block uses resource parameters to search for an RDS option group, and then tests that RDS option group.  If no RDS option group match, no error is raised, but the `exists` matcher will return `false` and all properties will be `nil`.

RDS gives you access to the capabilities of a MySQL, MariaDB, PostgreSQL, Microsoft SQL Server, Oracle, or Amazon Aurora database server.

## Syntax
Ensure if the option group exists

    describe aws_rds_group_option('default:aurora-5-6') do
      it { should exist }
    end

    # Can also use hash syntax
    describe aws_rds_group_option(option_group_name: 'default:aurora-5-6') do
      it { should exist }
    end

#### Parameters

`option\_group\_name`  _(required)_

This resource accepts a single parameter, the user-supplied option_group_name. This parameter isn't case-sensitive.
This can be passed either as a string or as a `option_group_name: 'value'` key-value entry in a hash.

See also the [AWS documentation on RDS Option Group](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-optiongroup.html).

## Properties
|Property                     | Description|
| ---                         | --- |
|option_group_name    | The name RDS option group. |
|option_group_description   | The name of the database associated with each RDS cluster. | 
|engine_name    | The name of the engine associated with each RDS cluster. |
|major_engine_version   | The major engine version of a option group. | 
|option_group_arn    | The arn of a option group.|
|vpc_id  | The vpc id of  option group. | 
|allows_vpc_and_non_vpc_instance_memberships    | The storage allocated to each cluster. |

For a comprehensive list of properties available to test on an RDS option group see the [AWS Response Object](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/RDS/DBCluster.html).

## Examples

##### Test the engine used with an aws_rds_group_option

    describe aws_rds_group_option(option_group_name: 'mysql') do
      its('engine_name')         { should eq 'mysql' }
      its('major_engine_version') { should eq '5.6.37' }
    end

##### Test the options to allocated to an aws_rds_group_option

    describe aws_rds_group_option(option_group_name: 'mysql') do
      its('options.option_name') { should eq 'test' }
      its('options.permanent') { should eq true }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

    describe aws_rds_group_option(option_group_name: 'mysql') do
      it { should exist }
    end

    describe aws_rds_group_option(option_group_name: 'mysql') do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `RDS:Client:OptionGroups` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon RDS](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonrds.html).
