---
title: About aws_rds_group_options Resource
---

# aws\_rds\_group\_options

Use the `aws_rds_group_options` InSpec audit resource to test detailed properties of a group of Amazon Relational Database Service (RDS) clusters.

RDS gives you access to the capabilities of a MySQL, MariaDB, PostgreSQL, Microsoft SQL Server, Oracle, or Amazon Aurora database server.

## Syntax

An `aws_rds_group_options` resource block uses resource parameters to search for an RDS option group, and then tests that RDS option group.  If no RDS option group match, no error is raised, but the `exists` matcher will return `false` and all properties will be `nil`.
describe aws_rds_group_option(engine_name: 'mysql') do
it { should exist }
end

    # Can also use hash syntax
    describe aws_rds_group_options do
      it { should exist }
    end

#### Parameters

|Property                     | Description|
| ---                         | --- |
|cluster\_identifier    | The unique IDs of the RDS clusters returned. |
|database\_name    | The name of the database associated with each RDS cluster. | 
|cluster_\members    | The RDS instances attached to each RDS cluster. |
|engine    | The name of the database engine used by each cluster. | 
|engine\_version    | The version of the database engine used by each cluster. |
|status   | The current status of each cluster. | 
|allocated\_storage    | The storage allocated to each cluster. |
|storage\_encrypted    | Returns T/F whether the cluster is encrypted or not. | 
|availability\_zones    | A list of availability zones of the RDS clusters returned.  |
|multi\_az   | Returns T/F depending on whether multiple availability zones are used in the cluster. | 
|arn   | The unique Amazon resource name of the RDS clusters. |    


See also the [AWS documentation on RDS cluster](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Aurora.Overview.html).

## Properties

For a comprehensive list of properties available to test on an RDS cluster see the [AWS Response Object](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/RDS/DBCluster.html).

## Examples

##### Test the engine used with an aws_rds_group_option

    describe aws_rds_group_options do
      its('engine_name')         { should include 'mysql' }
      its('major_engine_version') { should include '5.6.37' }
    end

#####Ensure a specific cluster exists
    describe aws_rds_group_options do
      its('option_group_name') { should include 'option_group_name8-test }
    end

##### Use the InSpec resource to request the IDs of all RDS clusters, then test in-depth using `aws_rds_cluster` to ensure all clusters are encrypted and have a sensible size.
    aws_rds_group_options.option_group_name.each do |option_group_name|
        describe  aws_rds_group_option(option_group_name) do
          it { should exist }
      end
    end



## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

#### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

    describe aws_rds_group_options do
      it { should exist }
    end

    describe aws_rds_group_options do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `rds:DescribeDBclusters` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon RDS](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonrds.html).
