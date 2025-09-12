+++
title = "aws_elasticsearchservice_domain resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_elasticsearchservice_domain"
identifier = "inspec/resources/aws/aws_elasticsearchservice_domain resource"
parent = "inspec/resources/aws"
+++

Use the `aws_elasticsearchservice_domain` InSpec audit resource to test properties of a single specific Elasticsearch domain.

The AWS::Elasticsearch::Domain resource creates an Amazon Elasticsearch Service (Amazon ES) domain.

For additional information, including details on parameters and properties, see the [AWS documentation on Elasticsearch Domain](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticsearch-domain.html).

## Syntax

Ensure that a domain name exists.

```ruby
describe aws_elasticsearchservice_domain(domain_name: 'DOMAIN_NAME') do
  it { should exist }
end
```

## Parameters

`domain_name` _(required)_

: The name of an Elasticsearch domain.
  Pass the domain name as a key-value entry in a hash.

## Properties

`domain_id`
: The unique identifier for the specified Elasticsearch domain.

`domain_name`
: The name of an Elasticsearch domain.

`arn`
: The Amazon resource name (ARN) of an Elasticsearch domain.

`created`
: The domain creation status. `true` if the creation of an Elasticsearch domain is complete. `false` if domain creation is still in progress.

`deleted`
: The domain deletion status. `true` if a delete request has been received for the domain but resource cleanup is still in progress. `false` if the domain has not been deleted. Once domain deletion is complete, the status of the domain is no longer returned.

`endpoint`
: The Elasticsearch domain endpoint that you use to submit index and search requests.

`endpoints`
: Key-value map containing the Elasticsearch domain endpoints used to submit index and search requests.

`processing`
: The status of the Elasticsearch domain configuration. `true` if Amazon Elasticsearch Service is processing configuration changes. `false` if the configuration is active.

`upgrade_processing`
: The status of an Elasticsearch domain version upgrade. `true` if Amazon Elasticsearch Service is undergoing a version upgrade. `false` if the configuration is active.

`elasticsearch_version`
: The elasticsearch version.

`elasticsearch_cluster_config (instance_type)`
: The instance type for an Elasticsearch cluster. UltraWarm instance types are not supported for data instances.

`elasticsearch_cluster_config (instance_count)`
: The number of instances in the specified domain cluster.

`elasticsearch_cluster_config (dedicated_master_enabled)`
: A boolean value to indicate whether a dedicated master node is enabled.

`elasticsearch_cluster_config (zone_awareness_enabled)`
: A boolean value to indicate whether zone awareness is enabled.

`elasticsearch_cluster_config (zone_awareness_config (availability_zone_count))`
: An integer value to indicate the number of availability zones for a domain when zone awareness is enabled. This should be equal to number of subnets if VPC endpoints is enabled.

`elasticsearch_cluster_config (dedicated_master_type)`
: The instance type for a dedicated master node.

`elasticsearch_cluster_config (dedicated_master_count)`
: Total number of dedicated master nodes, active and on standby, for the cluster.

`elasticsearch_cluster_config (warm_enabled)`
: True to enable warm storage.

`elasticsearch_cluster_config (warm_type)`
: The instance type for the Elasticsearch cluster's warm nodes.

`elasticsearch_cluster_config (warm_count)`
: The number of warm nodes in the cluster.

`ebs_options (ebs_enabled)`
: Specifies whether EBS-based storage is enabled.

`ebs_options (volume_type)`
: Specifies the volume type for EBS-based storage.

`ebs_options (volume_size)`
: Integer to specify the size of an EBS volume.

`ebs_options (iops)`
: Specifies the IOPD for a Provisioned IOPS EBS volume (SSD).

`access_policies`
: IAM access policy as a JSON-formatted string.

`snapshot_options (automated_snapshot_start_hour)`
: Specifies the time, in UTC format, when the service takes a daily automated snapshot of the specified Elasticsearch domain. Default value is 0 hours.

`vpc_options (vpc_id)`
: The VPC Id for the Elasticsearch domain. Exists only if the domain was created with VPCOptions.

`vpc_options (subnet_ids)`
: Specifies the subnets for VPC endpoint.

`vpc_options (availability_zones)`
: The availability zones for the Elasticsearch domain. Exists only if the domain was created with VPCOptions.

`vpc_options (security_group_ids)`
: Specifies the security groups for VPC endpoint.

`cognito_options (enabled)`
: Specifies the option to enable Cognito for Kibana authentication.

`cognito_options (user_pool_id)`
: Specifies the Cognito user pool ID for Kibana authentication.

`cognito_options (identity_pool_id)`
: Specifies the Cognito identity pool ID for Kibana authentication.

`cognito_options (role_arn)`
: Specifies the role ARN that provides Elasticsearch permissions for accessing Cognito resources.

`encryption_at_rest_options (enabled)`
: Specifies the option to enable Encryption At Rest.

`encryption_at_rest_options (kms_key_id)`
: Specifies the KMS Key ID for Encryption At Rest options.

`node_to_node_encryption_options (enabled)`
: Specify true to enable node-to-node encryption.

`advanced_options`
: Additional options to specify for the Amazon ES domain.

`log_publishing_options (cloud_watch_logs_log_group_arn)`
: ARN of the Cloudwatch log group to which log needs to be published.

`log_publishing_options (enabled)`
: Specifies whether given log publishing option is enabled or not.

`service_software_options (current_version)`
: The current service software version that is present on the domain.

`service_software_options (new_version)`
: The new service software version if one is available.

`service_software_options (update_available)`
: Whether you are able to update your service software version. Valid values: `true` or `false`.

`service_software_options (cancellable)`
: Whether you are able to cancel your service software version update. Valid values: `true` or `false`.

`service_software_options (update_status)`
: The status of your service software update. Valid values: `ELIGIBLE`, `PENDING_UPDATE`, `IN_PROGRESS` , `COMPLETED`, and `NOT_ELIGIBLE`.

`service_software_options (description)`
: The description of the UpdateStatus.

`service_software_options (automated_update_date)`
: Timestamp, in Epoch time, until which you can manually request a service software update. After this date, we automatically update your service software.

`service_software_options (optional_deployment)`
: Whether service software is never automatically updated after `AutomatedUpdateDate`. Valid values: `true` or `false`.

`domain_endpoint_options (enforce_https)`
: Specify if only HTTPS endpoint should be enabled for the Elasticsearch domain.

`domain_endpoint_options (tls_security_policy)`
: Specify the TLS security policy that needs to be applied to the HTTPS endpoint of Elasticsearch domain. Valid values are: `Policy-Min-TLS-1-0-2019-07` and `Policy-Min-TLS-1-2-2019-07`.

`domain_endpoint_options (custom_endpoint_enabled)`
: Specify if custom endpoint should be enabled for the Elasticsearch domain. Valid values: `true` or `false`.

`domain_endpoint_options (custom_endpoint)`
: Specify the fully qualified domain for your custom endpoint.

`domain_endpoint_options (custom_endpoint_certificate_arn)`
: Specify ACM certificate ARN for your custom endpoint.

`advanced_security_options (enabled)`
: `true` if advanced security is enabled. Valid values: `true` or `false`.

`advanced_security_options (internal_user_database_enabled)`
: `true` if the internal user database is enabled. Valid values: `true` or `false`.

`advanced_security_options (saml_options (enabled))`
: `true` if SAML is enabled. Valid values: `true` or `false`.

`advanced_security_options (saml_options (idp (metadata_content)))`
: The metadata of the SAML application in XML format.

`advanced_security_options (saml_options (idp (entity_id)))`
: The unique entity ID of the application in SAML Identity Provider.

`advanced_security_options (saml_options (subject_key))`
: The key used for matching the SAML Subject attribute.

`advanced_security_options (saml_options (roles_key))`
: The key used for matching the SAML Roles attribute.

`advanced_security_options (saml_options (session_timeout_minutes))`
: The duration, in minutes, after which a user session becomes inactive.

## Examples

**Ensure a domain name is available.**

```ruby
describe aws_elasticsearchservice_domain(domain_name: 'DOMAIN_NAME') do
  its('domain_name') { should eq 'DOMAIN_NAME' }
end
```

**Verify the ARN of a desired domain.**

```ruby
describe aws_elasticsearchservice_domain(domain_name: 'DOMAIN_NAME') do
    its('arn') { should eq 'ELASTICSEARCH_DOMAIN_ARN' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_elasticsearchservice_domain(domain_name: 'DOMAIN_NAME') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_elasticsearchservice_domain(domain_name: 'DOMAIN_NAME') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the domain name is available.

```ruby
describe aws_elasticsearchservice_domain(domain_name: 'DOMAIN_NAME') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="ElasticsearchService:Client:DescribeElasticsearchDomainResponse" %}}
