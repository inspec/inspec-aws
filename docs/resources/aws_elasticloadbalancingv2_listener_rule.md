---
title: About the aws_elasticloadbalancingv2_listener_rule Resource
platform: aws
---

# aws\_elasticloadbalancingv2\_listener\_rule

Use the `aws_elasticloadbalancingv2_listener_rule` InSpec audit resource to test properties of a single specific ELBv2 Listener Rule.

The AWS::ElasticLoadBalancingV2::ListenerRule specifies a listener rule. The listener must be associated with an Application Load Balancer. Each rule consists of a priority, one or more actions, and one or more conditions.

## Syntax

Ensure that a rule exists.
    describe aws_elasticloadbalancingv2_listener_rule(rule_arn: 'test_rule') do
      it { should exist }
    end

## Parameters

`rule_arn` _(required)_

For additional information, see the [AWS documentation on ELBv2 Listener Rule](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-listenerrule.html).

## Properties

| Property | Description|
| --- | --- |
| rule_arn | The Amazon Resource Names (ARN) of the rules. |
| priority | The priority. |
| conditions (field) | The field in the HTTP request. The following are the possible values are http-header, http-request-method,host-header,path-pattern,query-string, and source-ip |
| conditions (values) | The condition value. Specify only when Field is host-header or path-pattern . Alternatively, to specify multiple host names or multiple path patterns, use HostHeaderConfig or PathPatternConfig. |
| conditions (host_header_config (values)) | One or more host names. The maximum size of each name is 128 characters. The comparison is case insensitive. The following wildcard characters are supported: * (matches 0 or more characters) and ? (matches exactly 1 character). |
| conditions (path_pattern_config (values)) | One or more path patterns to compare against the request URL. The maximum size of each string is 128 characters. The comparison is case sensitive. The following wildcard characters are supported: * (matches 0 or more characters) and ? (matches exactly 1 character). |
| conditions (http_header_config (http_header_name)) | The name of the HTTP header field. The maximum size is 40 characters. The header name is case insensitive. The allowed characters are specified by RFC 7230. Wildcards are not supported. |
| conditions (http_header_config (Values)) | One or more strings to compare against the value of the HTTP header. The maximum size of each string is 128 characters. The comparison strings are case insensitive. The following wildcard characters are supported: * (matches 0 or more characters) and ? (matches exactly 1 character).
If the same header appears multiple times in the request, we search them in order until a match is found.
If you specify multiple strings, the condition is satisfied if one of the strings matches the value of the HTTP header. To require that all of the strings are a match, create one condition per string. |
| conditions (query_string_config (values (key))) | The key. You can omit the key. |
| conditions (query_string_config (values (value))) | The value. |
| conditions (http_request_method_config (values)) | The name of the request method. The maximum size is 40 characters. The allowed characters are A-Z, hyphen (-), and underscore (_). The comparison is case sensitive. Wildcards are not supported; therefore, the method name must be an exact match.
If you specify multiple strings, the condition is satisfied if one of the strings matches the HTTP request method. We recommend that you route GET and HEAD requests in the same way, because the response to a HEAD request may be cached. |
| conditions (source_ip_config (values)) | One or more source IP addresses, in CIDR format. You can use both IPv4 and IPv6 addresses. Wildcards are not supported.
If you specify multiple addresses, the condition is satisfied if the source IP address of the request matches one of the CIDR blocks. This condition is not satisfied by the addresses in the X-Forwarded-For header. To search for addresses in the X-Forwarded-For header, use HttpHeaderConditionConfig . |
| actions (type) | The type of action. |
| actions (target_group_arn) | The Amazon Resource Name (ARN) of the target group. Specify only when Type is forward and you want to route to a single target group. To route to one or more target groups, use ForwardConfig instead. |
| actions (authenticate_oidc_config (issuer)) | The OIDC issuer identifier of the IdP. This must be a full URL, including the HTTPS protocol, the domain, and the path. |
| actions (authenticate_oidc_config (authorization_endpoint)) | The authorization endpoint of the IdP. This must be a full URL, including the HTTPS protocol, the domain, and the path. |
| actions (authenticate_oidc_config (token_endpoint)) | The token endpoint of the IdP. This must be a full URL, including the HTTPS protocol, the domain, and the path. |
| actions (authenticate_oidc_config (user_info_endpoint)) | The user info endpoint of the IdP. This must be a full URL, including the HTTPS protocol, the domain, and the path. |
| actions (authenticate_oidc_config (client_id)) | The OAuth 2.0 client identifier. |
| actions (authenticate_oidc_config (client_secret)) | The OAuth 2.0 client secret. This parameter is required if you are creating a rule. If you are modifying a rule, you can omit this parameter if you set UseExistingClientSecret to true. |
| actions (authenticate_oidc_config (session_cookie_name)) | The name of the cookie used to maintain session information. The default is AWSELBAuthSessionCookie. |
| actions (authenticate_oidc_config (scope)) | The set of user claims to be requested from the IdP. The default is openid . To verify which scope values your IdP supports and how to separate multiple values, see the documentation for your IdP. |
| actions (authenticate_oidc_config (session_timeout)) | The maximum duration of the authentication session, in seconds. The default is 604800 seconds (7 days). |
| actions (authenticate_oidc_config (authentication_request_extra_params)) | The query parameters (up to 10) to include in the redirect request to the authorization endpoint. |
| actions (authenticate_oidc_config (on_unauthenticated_request)) | The behavior if the user is not authenticated. The following are possible values are deny, allow and autheticate |
| actions (authenticate_oidc_config (use_existing_client_secret)) | Indicates whether to use the existing client secret when modifying a rule. If you are creating a rule, you can omit this parameter or set it to false. |
| actions (authenticate_cognito_config (user_pool_arn)) | The Amazon Resource Name (ARN) of the Amazon Cognito user pool. |
| actions (authenticate_cognito_config (user_pool_client_id)) | The ID of the Amazon Cognito user pool client. |
| actions (authenticate_cognito_config (user_pool_domain)) | The domain prefix or fully-qualified domain name of the Amazon Cognito user pool. |
| actions (authenticate_cognito_config (session_cookie_name)) | The name of the cookie used to maintain session information. The default is AWSELBAuthSessionCookie. |
| actions (authenticate_cognito_config (scope)) | The set of user claims to be requested from the IdP. The default is openid . To verify which scope values your IdP supports and how to separate multiple values, see the documentation for your IdP. |
| actions (authenticate_cognito_config (session_timeout)) | The maximum duration of the authentication session, in seconds. The default is 604800 seconds (7 days). |
| actions (authenticate_cognito_config (authentication_request_extra_params)) | The query parameters (up to 10) to include in the redirect request to the authorization endpoint. |
| actions (authenticate_cognito_config (on_unauthenticated_request)) | The behavior if the user is not authenticated. The following are possible values are deny, allow and authenticate. |
| actions (order) | The order for the action. This value is required for rules with multiple actions. The action with the lowest value for order is performed first. |
| actions (redirect_config (protocol)) | The protocol. You can specify HTTP, HTTPS, or #{protocol}. You can redirect HTTP to HTTP, HTTP to HTTPS, and HTTPS to HTTPS. You cannot redirect HTTPS to HTTP. |
| actions (redirect_config (port)) | The port. You can specify a value from 1 to 65535 or #{port}. |
| actions (redirect_config (host)) | The hostname. This component is not percent-encoded. The hostname can contain #{host}. |
| actions (redirect_config (path)) | The absolute path, starting with the leading "/". This component is not percent-encoded. The path can contain #{host}, #{path}, and #{port}. |
| actions (redirect_config (query)) | The query parameters, URL-encoded when necessary, but not percent-encoded. Do not include the leading "?", as it is automatically added. You can specify any of the reserved keywords. |
| actions (redirect_config (status_code)) | The HTTP redirect code. The redirect is either permanent (HTTP 301) or temporary (HTTP 302). |
| actions (fixed_response_config (message_body)) | The message. |
| actions (fixed_response_config (status_code)) | The HTTP response code (2XX, 4XX, or 5XX). |
| actions (fixed_response_config (content_type)) | The content type. Valid Values: text/plain, text/css, text/html, application/javascript, application/json |
| actions (fixed_response_config (target_groups (target_group_arn))) | The Amazon Resource Name (ARN) of the target group. |
| actions (fixed_response_config (target_groups (weight))) | The weight. The range is 0 to 999. |
| actions (fixed_response_config (target_group_stickiness_config (enabled))) | Indicates whether target group stickiness is enabled. |
| actions (fixed_response_config (target_group_stickiness_config (duration_seconds))) | The time period, in seconds, during which requests from a client should be routed to the same target group. The range is 1-604800 seconds (7 days). |
| is_default | Indicates whether this is the default rule. |

## Examples

### Ensure a rule_arn is available.
    describe aws_elasticloadbalancingv2_listener_rule(rule_arn: 'test_rule') do
      its('rule_arn') { should eq 'test_rule' }
    end

### Verify the priority of the desired rule arn
    describe aws_elasticloadbalancingv2_listener_rule(rule_arn: 'test_rule') do
        its('priority') { should eq 1 }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_elasticloadbalancingv2_listener_rule(rule_arn: 'test_rule') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.
      
    describe aws_elasticloadbalancingv2_listener_rule(rule_arn: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the work_group name is available.

    describe aws_elasticloadbalancingv2_listener_rule(rule_arn: 'dummy') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `elb_client_v2.describe_rules` action with `Effect` set to `Allow`.