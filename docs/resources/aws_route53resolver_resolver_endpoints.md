---
title: About the aws_route53resolver_resolver_endpoints Resource
platform: aws
---

# aws\_route53resolver\_resolver\_endpoints

Use the `aws_route53resolver_resolver_endpoints` InSpec audit resource to test properties of multiple AWS Route53 Resolver endpoints.

There are two types of Resolver endpoints, inbound and outbound. An inbound Resolver endpoint forwards DNS queries to the DNS service for a VPC from your network. An outbound Resolver endpoint forwards DNS queries from the DNS service for a VPC to your network.

## Syntax

Ensure that an endpoint exists.

    describe aws_route53resolver_resolver_endpoints do
      it { should exist }
    end

## Parameters

This resource does not expect any parameters.

For additional information, see the [AWS documentation on AWS Route53Resolver Resolver Endpoint](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-route53resolver-resolverendpoint.html).

## Properties

| Property | Description|
| --- | --- |
| ids | The ID of the Resolver endpoint. |
| creator_request_ids | A unique string that identifies the request that created the Resolver endpoint. The `CreatorRequestId` allows failed requests to be retried without the risk of running the operation twice. |
| arns | The ARN (Amazon Resource Name) for the Resolver endpoint. |
| names | The name that you assigned to the Resolver endpoint when you submitted a `CreateResolverEndpoint` request. |
| security_group_ids | The ID of one or more security groups that control access to this VPC. The security group must include one or more inbound rules (for inbound endpoints) or outbound rules (for outbound endpoints). Inbound and outbound rules must allow TCP and UDP access. For inbound access, open port 53. For outbound access, open the port that you're using for DNS queries on your network. |
| directions | Indicates whether the Resolver endpoint allows inbound or outbound DNS queries. Valid values: `INBOUND`, `OUTBOUND` |
| ip_address_counts | The number of IP addresses that the Resolver endpoint can use for DNS queries. |
| host_vpc_ids | The ID of the VPC that you want to create the Resolver endpoint in. |
| statuses | A code that specifies the current status of the Resolver endpoint. Valid values are: `CREATING`, `OPERATIONAL`, `UPDATING`, `AUTO_RECOVERING`, `ACTION_NEEDED`, `DELETING`. |
| status_messages | A detailed description of the status of the Resolver endpoint. |
| creation_times | The date and time that the endpoint was created, in Unix time format and Coordinated Universal Time (UTC). |
| modification_times | The date and time that the endpoint was last modified, in Unix time format and Coordinated Universal Time (UTC). |

## Examples

### Ensure an endpoint name is available.

    describe aws_route53resolver_resolver_endpoints do
      its('names') { should include 'ENDPOINT_NAME' }
    end

### Ensure that an endpoint has the `CREATING` status.

    describe aws_route53resolver_resolver_endpoints do
        its('statuses') { should include 'CREATING' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_route53resolver_resolver_endpoints do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.
      
    describe aws_route53resolver_resolver_endpoints do
      it { should_not exist }
    end

### be_available

Use `should` to check if the endpoint name is available.

    describe aws_route53resolver_resolver_endpoints do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `Route53Resolver:Client:ListResolverEndpointsResponse` action with `Effect` set to `Allow`.
