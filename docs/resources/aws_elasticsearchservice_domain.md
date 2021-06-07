---
title: About the aws_elasticsearchservice_domain Resource
platform: aws
---

# aws\_elasticsearchservice\_domain

Use the `aws_elasticsearchservice_domain` InSpec audit resource to test properties of a single specific Elasticsearch Domain.

The AWS::Elasticsearch::Domain resource creates an Amazon Elasticsearch Service (Amazon ES) domain.

## Syntax

Ensure that a domain name exists.
    describe aws_elasticsearchservice_domain(domain_name: 'DomainName') do
      it { should exist }
    end

## Parameters

`domain_name` _(required)_

For additional information, see the [AWS documentation on Elasticsearch Domain](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticsearch-domain.html).

## Properties

| Property | Description|
| --- | --- |
| domain_id | The unique identifier for the specified Elasticsearch domain. |
| domain_name | The name of an Elasticsearch domain. Domain names are unique across the domains owned by an account within an AWS region. Domain names start with a letter or number and can contain the following characters: a-z (lowercase), 0-9, and - (hyphen). |
| arn | The Amazon resource name (ARN) of an Elasticsearch domain. |
| created | The domain creation status. True if the creation of an Elasticsearch domain is complete. False if domain creation is still in progress. |
| deleted | The domain deletion status. True if a delete request has been received for the domain but resource cleanup is still in progress. False if the domain has not been deleted. Once domain deletion is complete, the status of the domain is no longer returned. |
| endpoint | The Elasticsearch domain endpoint that you use to submit index and search requests. |
| endpoints | Map containing the Elasticsearch domain endpoints used to submit index and search requests. Example key, value : 'vpc','vpc-endpoint-h2dsd34efgyghrtguk5gt6j2foh4.us-east-1.es.amazonaws.com'. |
| processing | The status of the Elasticsearch domain configuration. True if Amazon Elasticsearch Service is processing configuration changes. False if the configuration is active. |
| upgrade_processing | The status of an Elasticsearch domain version upgrade. True if Amazon Elasticsearch Service is undergoing a version upgrade. False if the configuration is active. |
| elasticsearch_version | The elasticsearch version. |
| elasticsearch_cluster_config (instance_type) | The instance type for an Elasticsearch cluster. UltraWarm instance types are not supported for data instances. |
| elasticsearch_cluster_config (instance_count) | The number of instances in the specified domain cluster. |
| elasticsearch_cluster_config (dedicated_master_enabled) | A boolean value to indicate whether a dedicated master node is enabled. See About Dedicated Master Nodes for more information. |
| elasticsearch_cluster_config (zone_awareness_enabled) | A boolean value to indicate whether zone awareness is enabled. See About Zone Awareness for more information. |
| elasticsearch_cluster_config (zone_awareness_config (availability_zone_count)) | An integer value to indicate the number of availability zones for a domain when zone awareness is enabled. This should be equal to number of subnets if VPC endpoints is enabled. |
| elasticsearch_cluster_config (dedicated_master_type) | The instance type for a dedicated master node. |
| elasticsearch_cluster_config (dedicated_master_count) | Total number of dedicated master nodes, active and on standby, for the cluster.|
| elasticsearch_cluster_config (warm_enabled) | True to enable warm storage. |
| elasticsearch_cluster_config (warm_type) | The instance type for the Elasticsearch cluster's warm nodes. |
| elasticsearch_cluster_config (warm_count) | The number of warm nodes in the cluster. |
| ebs_options (ebs_enabled) | Specifies whether EBS-based storage is enabled. |
| ebs_options (volume_type) | Specifies the volume type for EBS-based storage. |
| ebs_options (volume_size) | Integer to specify the size of an EBS volume. |
| ebs_options (iops) | Specifies the IOPD for a Provisioned IOPS EBS volume (SSD). |
| access_policies | IAM access policy as a JSON-formatted string. |
| snapshot_options (automated_snapshot_start_hour) | Specifies the time, in UTC format, when the service takes a daily automated snapshot of the specified Elasticsearch domain. Default value is 0 hours. |
| vpc_options (vpc_id) | The VPC Id for the Elasticsearch domain. Exists only if the domain was created with VPCOptions. |
| vpc_options (subnet_ids) | Specifies the subnets for VPC endpoint. |
| vpc_options (availability_zones) | The availability zones for the Elasticsearch domain. Exists only if the domain was created with VPCOptions. |
| vpc_options (security_group_ids) | Specifies the security groups for VPC endpoint. |
| cognito_options (enabled) | Specifies the option to enable Cognito for Kibana authentication. |
| cognito_options (user_pool_id) | Specifies the Cognito user pool ID for Kibana authentication. |
| cognito_options (identity_pool_id) | Specifies the Cognito identity pool ID for Kibana authentication. |
| cognito_options (role_arn) | Specifies the role ARN that provides Elasticsearch permissions for accessing Cognito resources. |
| encryption_at_rest_options (enabled) | Specifies the option to enable Encryption At Rest. |
| encryption_at_rest_options (kms_key_id) | Specifies the KMS Key ID for Encryption At Rest options. |
| node_to_node_encryption_options (enabled) | Specify true to enable node-to-node encryption. |
| advanced_options | Specifies the status of the AdvancedOptions. |
| log_publishing_options (cloud_watch_logs_log_group_arn) | ARN of the Cloudwatch log group to which log needs to be published. |
| log_publishing_options (enabled) | Specifies whether given log publishing option is enabled or not. |
| service_software_options (current_version) | The current service software version that is present on the domain. |
| service_software_options (new_version) | The new service software version if one is available. |
| service_software_options (update_available) | True if you are able to update you service software version. False if you are not able to update your service software version. |
| service_software_options (cancellable) | True if you are able to cancel your service software version update. False if you are not able to cancel your service software version. |
| service_software_options (update_status) | The status of your service software update. This field can take the following values: ELIGIBLE , PENDING_UPDATE , IN_PROGRESS , COMPLETED , and NOT_ELIGIBLE. |
| service_software_options (description) | The description of the UpdateStatus. |
| service_software_options (automated_update_date) | Timestamp, in Epoch time, until which you can manually request a service software update. After this date, we automatically update your service software. |
| service_software_options (optional_deployment) | True if a service software is never automatically updated. False if a service software is automatically updated after AutomatedUpdateDate. |
| domain_endpoint_options (enforce_https) | Specify if only HTTPS endpoint should be enabled for the Elasticsearch domain. |
| domain_endpoint_options (tls_security_policy) | Specify the TLS security policy that needs to be applied to the HTTPS endpoint of Elasticsearch domain. It can be one of the following values are Policy-Min-TLS-1-0-2019-07 and Policy-Min-TLS-1-2-2019-07. |
| domain_endpoint_options (custom_endpoint_enabled) | Specify if custom endpoint should be enabled for the Elasticsearch domain. |
| domain_endpoint_options (custom_endpoint) | Specify the fully qualified domain for your custom endpoint. |
| domain_endpoint_options (custom_endpoint_certificate_arn) | Specify ACM certificate ARN for your custom endpoint. |
| advanced_security_options (enabled) | True if advanced security is enabled. |
| advanced_security_options (internal_user_database_enabled) | True if the internal user database is enabled. |
| advanced_security_options (saml_options (enabled)) | True if SAML is enabled. |
| advanced_security_options (saml_options (idp (metadata_content))) | The Metadata of the SAML application in xml format. |
| advanced_security_options (saml_options (idp (entity_id))) | The unique Entity ID of the application in SAML Identity Provider. |
| advanced_security_options (saml_options (subject_key)) | The key used for matching the SAML Subject attribute. |
| advanced_security_options (saml_options (roles_key)) | The key used for matching the SAML Roles attribute. |
| advanced_security_options (saml_options (session_timeout_minutes)) | The duration, in minutes, after which a user session becomes inactive. |

## Examples

### Ensure a domain name is available.
    describe aws_elasticsearchservice_domain(domain_name: 'DomainName') do
      its('domain_name') { should eq 'DomainName' }
    end

### Verify the arn of a desired domain.
    describe aws_elasticsearchservice_domain(domain_name: 'DomainName') do
        its('arn') { should eq 'test_arn' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.
    describe aws_elasticsearchservice_domain(domain_name: 'DomainName') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.
    describe aws_elasticsearchservice_domain(domain_name: 'dummy') do
      it { should_not exist }
    end

### be_available
Use `should` to check if the domain name is available.

    describe aws_elasticsearchservice_domain(domain_name: 'DomainName') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `elasticsearch_service_client.list_domain_names` action with `Effect` set to `Allow`.