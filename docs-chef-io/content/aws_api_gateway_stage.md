+++
title = "aws_api_gateway_stage resource"

draft = false


[menu.aws]
title = "aws_api_gateway_stage"
identifier = "inspec/resources/aws/aws_api_gateway_stage resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_stage` InSpec audit resource to test properties of a single AWS API Gateway stage.

The `AWS::ApiGateway::Stage` resource deploys an API Gateway REST API resource to a stage so that clients can call the API over the internet. The stage acts as an environment.

For additional information, including details on parameters and properties, see the [AWS API Gateway stage documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-stage.html).

## Syntax

Ensure that the stage exists.

```ruby
describe aws_api_gateway_stage(rest_api_id: 'REST_API_ID', stage_name: 'STAGE_NAME') do
  it { should exist }
end
```

## Parameters

`rest_api_id` _(required)_

: The ID of the REST API resource that you're deploying with this stage.

`stage_name` _(required)_

: The API Gateway stage name.

## Properties

`deployment_id`
: The identifier for the deployment attached to stage resource.

`description`
: The description for the stage resource.

`created_date`
: The date and time that the stage resource was created.

`stage_name`
: The name for the stage resource.

`client_certificate_id`
: The client certificate identifier for the stage resource.

`cache_cluster_enabled`
: Specifies whether a cache cluster is enabled for the stage.

`cache_cluster_size`
: The size of the cache cluster for the stage, if enabled.

`cache_cluster_status`
: The status of the cache cluster for the stage, if enabled.

`method_settings`
: A map that defines the method settings for a stage resource.

`method_settings (metrics_enabled)`
: Specifies whether Amazon CloudWatch metrics are enabled for this method.

`method_settings (logging_level)`
: Specifies the logging level for this method, which affects the log entries pushed to Amazon CloudWatch Logs.

`method_settings (data_trace_enabled)`
: Specifies whether data trace logging is enabled for this method, which affects the log entries pushed to Amazon CloudWatch Logs.

`method_settings (throttling_burst_limit)`
: Specifies the throttling burst limit.

`method_settings (throttling_rate_limit)`
: Specifies the throttling rate limit.

`method_settings (caching_enabled)`
: Specifies whether responses should be cached and returned for requests.

`method_settings (cache_ttl_in_seconds)`
: Specifies the time to live (TTL), in seconds, for cached responses.

`method_settings (cache_data_encrypted)`
: Specifies whether the cached responses are encrypted.

`method_settings (require_authorization_for_cache_control)`
: Specifies whether authorization is required for a cache invalidation request.

`method_settings (unauthorized_cache_control_header_strategy)`
: Specifies how to handle unauthorized requests for cache invalidation.

`variables`
: A map that defines the stage variables for a stage resource.

`documentation_version`
: The version of the associated API documentation.

`access_log_settings.format`
: A single line format of the access logs of data.

`access_log_settings.destination_arn`
: The Amazon Resource Name (ARN) of the CloudWatch Logs log group or Kinesis Data Firehose delivery stream to receive access logs.

`canary_settings.percent_traffic`
: The percent (0-100) of traffic diverted to a canary deployment.

`canary_settings.deployment_id`
: The identifier for the canary settings deployment.

`canary_settings.stage_variable_overrides`
: Stage variables overridden for a canary release deployment, including new stage variables introduced in the canary.

`canary_settings.use_stage_cache`
: A boolean flag to indicate whether the canary deployment uses the stage cache or not.

`tracing_enabled`
: Specifies whether active tracing with X-ray is enabled for the Stage.

`web_acl_arn`
: The ARN of the WebAcl associated with the Stage.

`tags`
: The collection of tags. Each tag element is associated with a given resource.

`last_updated_date`
: The timestamp when the stage last updated.

## Examples

Ensure that the stage name exists:

```ruby
describe aws_api_gateway_stage(rest_api_id: 'REST_API_ID', stage_name: 'STAGE_NAME') do
  its('stage_name') { should eq 'STAGE_NAME' }
end
```

Ensure that the client certificate ID exists:

```ruby
describe aws_api_gateway_stage(rest_api_id: 'REST_API_ID', stage_name: 'STAGE_NAME') do
    its('client_certificate_id') { should eq 'CLIENT_CERTIFICATE_ID' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_stage(rest_api_id: 'REST_API_ID', stage_name: 'STAGE_NAME') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_api_gateway_stage(rest_api_id: 'REST_API_ID', stage_name: 'STAGE_NAME') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_api_gateway_stage(rest_api_id: 'REST_API_ID', stage_name: 'STAGE_NAME') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="APIGateway:Client:Stage" %}}
