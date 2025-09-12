+++
title = "aws_elasticloadbalancingv2_listener_rule resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_elasticloadbalancingv2_listener_rule"
identifier = "inspec/resources/aws/aws_elasticloadbalancingv2_listener_rule resource"
parent = "inspec/resources/aws"
+++

Use the `aws_elasticloadbalancingv2_listener_rule` InSpec audit resource to test properties of a single listener rule for an Application Load Balancer. Each rule consists of a priority, one or more actions, and one or more conditions.

For additional information, including details on parameters and properties, see the [AWS documentation on ELBv2 Listener Rule](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-listenerrule.html).

## Syntax

Ensure that a rule exists.

```ruby
describe aws_elasticloadbalancingv2_listener_rule(rule_arn: 'RULE_ARN') do
  it { should exist }
end
```

## Parameters

`rule_arn` _(required)_

: The Amazon Resource Name (ARN) of the rule.

## Properties

`rule_arn`
: The Amazon Resource Names (ARN) of the rules.

`priority`
: The rule priority.

`conditions (field)`
: The field in the HTTP request. Valid values are `http-header`, `http-request-method`, `host-header`, `path-pattern`, `query-string, and source-ip`.

`conditions (values)`
: The condition value. Specify only when Field is `host-header` or `path-pattern`. Alternatively, to specify multiple host names or multiple path patterns, use `HostHeaderConfig` or `PathPatternConfig`.

`conditions (host_header_config (values))`
: One or more host names.

`conditions (path_pattern_config (values))`
: One or more path patterns to compare against the request URL.

`conditions (http_header_config (http_header_name))`
: The name of the HTTP header field.

`conditions (http_header_config (Values))`
: One or more strings to compare against the value of the HTTP header.

`conditions (query_string_config (values (key)))`
: The key of the query string configuration. You can omit the key.

`conditions (query_string_config (values (value)))`
: The value of the query string configuration.

`conditions (http_request_method_config (values))`
: The name of the request method.

`conditions (source_ip_config (values))`
: One or more source IP addresses, in CIDR format. Either IPv4 or IPv6 address.

`actions (type)`
: The type of action. Valid values: `authenticate-cognito`, `authenticate-oidc`, `fixed-response`, `forward`, `redirect`.

`actions (target_group_arn)`
: The ARN of the target group. Specified only when Type is `forward` and you are routing to a single target group. If routing to one or more target groups, `ForwardConfig` is used instead.

`actions (authenticate_oidc_config (issuer))`
: The OIDC issuer identifier of the IdP. This must be a full URL, including the HTTPS protocol, the domain, and the path.

`actions (authenticate_oidc_config (authorization_endpoint))`
: The authorization endpoint of the IdP. This must be a full URL, including the HTTPS protocol, the domain, and the path.

`actions (authenticate_oidc_config (token_endpoint))`
: The token endpoint of the IdP. This must be a full URL, including the HTTPS protocol, the domain, and the path.

`actions (authenticate_oidc_config (user_info_endpoint))`
: The user info endpoint of the IdP. This must be a full URL, including the HTTPS protocol, the domain, and the path.

`actions (authenticate_oidc_config (client_id))`
: The OAuth 2.0 client identifier.

`actions (authenticate_oidc_config (client_secret))`
: The OAuth 2.0 client secret.

`actions (authenticate_oidc_config (session_cookie_name))`
: The name of the cookie used to maintain session information. The default is `AWSELBAuthSessionCookie`.

`actions (authenticate_oidc_config (scope))`
: The set of user claims to be requested from the IdP. The default is `openid`.

`actions (authenticate_oidc_config (session_timeout))`
: The maximum duration of the authentication session, in seconds. The default is 604800 seconds (7 days).

`actions (authenticate_oidc_config (authentication_request_extra_params))`
: The query parameters (up to 10) to include in the redirect request to the authorization endpoint.

`actions (authenticate_oidc_config (on_unauthenticated_request))`
: The behavior if the user is not authenticated. Valid values are `deny`, `allow`, and `autheticate`.

`actions (authenticate_oidc_config (use_existing_client_secret))`
: Indicates whether to use the existing client secret when modifying a rule. If you are creating a rule, you can omit this parameter or set it to false.

`actions (authenticate_cognito_config (user_pool_arn))`
: The ARN of the Amazon Cognito user pool.

`actions (authenticate_cognito_config (user_pool_client_id))`
: The ID of the Amazon Cognito user pool client.

`actions (authenticate_cognito_config (user_pool_domain))`
: The domain prefix or fully-qualified domain name of the Amazon Cognito user pool.

`actions (authenticate_cognito_config (session_cookie_name))`
: The name of the cookie used to maintain session information. The default is `AWSELBAuthSessionCookie`.

`actions (authenticate_cognito_config (scope))`
: The set of user claims to be requested from the IdP. The default is `openid`.

`actions (authenticate_cognito_config (session_timeout))`
: The maximum duration of the authentication session, in seconds. The default is 604800 seconds (7 days).

`actions (authenticate_cognito_config (authentication_request_extra_params))`
: The query parameters (up to 10) to include in the redirect request to the authorization endpoint.

`actions (authenticate_cognito_config (on_unauthenticated_request))`
: The behavior if the user is not authenticated. The following are possible values are `deny`, `allow`, and `authenticate`.

`actions (order)`
: The order for the action. This value is required for rules with multiple actions.

`actions (redirect_config (protocol))`
: The protocol. Valid values are: `HTTP`, `HTTPS`, or `#{protocol}`.

`actions (redirect_config (port))`
: The port. Values range from 1 to 65535 or #{port}.

`actions (redirect_config (host))`
: The hostname. This component is not percent-encoded. The hostname can contain #{host}.

`actions (redirect_config (path))`
: The absolute path, starting with the leading "/". This component is not percent-encoded. The path can contain #{host}, #{path}, and #{port}.

`actions (redirect_config (query))`
: The query parameters, URL-encoded when necessary, but not percent-encoded. Do not include the leading "?", as it is automatically added. You can specify any of the reserved keywords.

`actions (redirect_config (status_code))`
: The HTTP redirect code. The redirect is either permanent (HTTP 301) or temporary (HTTP 302).

`actions (fixed_response_config (message_body))`
: The message from a custom HTTP response. Only valid when Type is `fixed-response`.

`actions (fixed_response_config (status_code))`
: The HTTP response code (2XX, 4XX, or 5XX) from a custom HTTP response.

`actions (fixed_response_config (content_type))`
: The content type from a custom HTTP response. Valid values: `text/plain`, `text/css`, `text/html`, `application/javascript`, `application/json`.

`actions (forward_config (target_groups ( target_group_tupple (target_group_arn))))`
: The ARN of the target group.

`actions (forward_config (target_groups ( target_group_tupple (weight))))`
: The weight of the target group. The range is 0 to 999.

`actions (fixed_response_config (target_group_stickiness_config (enabled)))`
: Indicates whether target group stickiness is enabled.

`actions (fixed_response_config (target_group_stickiness_config (duration_seconds)))`
: The time period, in seconds, during which requests from a client should be routed to the same target group. The range is 1-604800 seconds (7 days).

`is_default`
: Indicates whether this is the default rule.

## Examples

**Ensure a rule ARN is available.**

```ruby
describe aws_elasticloadbalancingv2_listener_rule(rule_arn: 'RULE_ARN') do
  its('rule_arn') { should eq 'RULE_ARN' }
end
```

**Verify the priority of the desired rule ARN.**

```ruby
describe aws_elasticloadbalancingv2_listener_rule(rule_arn: 'RULE_ARN') do
    its('priority') { should eq 1 }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_elasticloadbalancingv2_listener_rule(rule_arn: 'RULE_ARN') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_elasticloadbalancingv2_listener_rule(rule_arn: 'RULE_ARN') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the work_group name is available.

```ruby
describe aws_elasticloadbalancingv2_listener_rule(rule_arn: 'dummy') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="ElasticLoadBalancingV2:Client:DescribeRulesOutput" %}}
