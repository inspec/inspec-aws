---
title: About the aws_nat_gateways Resource
---

# aws\_nat\_gateways

Use the `aws_nat_gateways` InSpec audit resource to test the properties of all AWS NAT gateways owned by the AWS account.

## Syntax

An `aws_nat_gateways` resource block collects all of the NAT gateways and then tests that group.

    describe aws_nat_gateways do
      it { should exist }
    end 

#### Parameters

This resource does not expect any parameters.

## Properties

|Property            | Description |
| ---                | --- |
|ids                 | The ID of the NAT gateway. The field name is `id`.|
|names               | The value of the `Name` tag. It is `nil` if not defined. The field name is `name`.|
|vpc\_ids            | The ID of the VPC in which the NAT gateway is located. The field name is `vpc_id`.|
|subnet\_ids         | The ID of the subnet in which the NAT gateway is placed. The field name is `subnet_id`.|
|tags                | A hash, with each key-value pair corresponding to a NAT gateway tag. The field name is `tags`.|
|states              | The sate of the NAT gateway. Valid values are: `pending`, `failed`, `available`, `deleting` and `deleted`. The field name is `state`.|
|nat\_gateways       | A NAT gateway object with all the properties as documented [here](aws_nat_gateway.md). This can be used to test individual NAT gateways in-depth. The field name is `nat_gateway`. |


## Examples

##### Test that there are exactly 3 NAT gateways

    describe aws_nat_gateways do
      its('count') { should cmp 3 }
    end
    
##### Use this InSpec resource to filter NAT gateways with their name equal to `dev-nat-gateway`, then test in-depth using `nat_gateways`.

    aws_nat_gateways.where(name: 'dev-nat-gateway').nat_gateways.each do |nat_gateway|
      describe nat_gateway do
        its('nat_gateway_address_set') { should include(:private_ip => '10.0.1.68') }
        its('vpc_id') { should eq 'vpc-12345678' }
      end
    end
    
##### Use this InSpec resource to request the ids of all NAT gateways, then test in-depth using `aws_nat_gateway` InSpec singular AWS resource.
It should be noted that this will make additional API calls for every singular resource usage and increase the cost of the test in terms of time and internet traffic.

    aws_nat_gateways.ids.each do |id|
      describe aws_nat_gateway(id: id) do
        its('state') { should eq 'available' }
      end
    end
    
For more examples, please check the [integration tests](../../test/integration/verify/controls/aws_nat_gateways.rb).
    
    
## Matchers

For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/). 

#### exist

The control will pass if the describe returns at least one result.
The field names described in the [properties table](##-properties) should be used for the `<property>` in the `where` clause.

Use `should_not` to test the entity should not exist.

    describe aws_nat_gateways.where( <property>: <value>) do
      it { should exist }
    end
      
    describe aws_nat_gateways.where( <property>: <value>) do
      it { should_not exist }
    end

Please see [here](https://github.com/inspec/inspec/blob/master/docs/dev/filtertable-usage.md) for more information on how to use filter table.
            
## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:DescribeNatGateways` action set to allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
