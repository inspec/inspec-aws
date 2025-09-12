+++
title = "aws_elasticloadbalancingv2_listener resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_elasticloadbalancingv2_listener"
identifier = "inspec/resources/aws/aws_elasticloadbalancingv2_listener resource"
parent = "inspec/resources/aws"
+++

Use the `aws_elasticloadbalancingv2_listener` InSpec audit resource to test properties of a single Application Load Balancer or Network Load Balancer listener.

For additional information, including details on parameters and properties, see the [AWS documentation on ElasticLoadBalancingV2 Listener](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-listener.html).

## Syntax

Ensure that a listener arn exist.

```ruby
describe aws_elasticloadbalancingv2_listener(listener_arn: "LISTENER_ARN") do
  it { should exist }
end
```

Ensure that the listener has a desired port.

```ruby
describe aws_elasticloadbalancingv2_listener(listener_arn: "LISTENER_ARN") do
  its ('port') { should eq 80 }
end
```

## Parameters

`listener_arn` _(required)_

: The Amazon Resource Name (ARN) of the listener.

## Properties

`listener_arn`
: The Amazon Resource Name (ARN) of the listener.

`load_balancer_arn`
: The Amazon Resource Name (ARN) of the load balancer.

`port`
: The port on which the load balancer is listening.

`protocol`
: The protocol for connections from clients to the load balancer.

`certificates (certificate_arn)`
: The Amazon Resource Name (ARN) of the certificate.

`certificates (is_default)`
: Indicates whether the certificate is the default certificate. Do not set this value when specifying a certificate as an input. This value is not included in the output when describing a listener, but is included when describing listener certificates.

`ssl_policy`
: The security policy (HTTPS or TLS listener) that defines which protocols and ciphers are supported.

`default_actions (type)`
: The type of action.

`default_actions (target_group_arn)`
: The Amazon Resource Name (ARN) of the target group. Specify only when Type is forward and you want to route to a single target group. To route to one or more target groups, use ForwardConfig instead.

`default_actions (authenticate_oidc_config (issuer))`
: The OIDC issuer identifier of the IdP. This must be a full URL, including the HTTPS protocol, the domain, and the path.

`default_actions (authenticate_oidc_config (authorization_endpoint))`
: The authorization endpoint of the IdP. This must be a full URL, including the HTTPS protocol, the domain, and the path.

`default_actions (authenticate_oidc_config (token_endpoint))`
: The token endpoint of the IdP. This must be a full URL, including the HTTPS protocol, the domain, and the path.

`default_actions (authenticate_oidc_config (user_info_endpoint))`
: The user info endpoint of the IdP. This must be a full URL, including the HTTPS protocol, the domain, and the path.

`default_actions (authenticate_oidc_config (client_id))`
: The OAuth 2.0 client identifier.

`default_actions (authenticate_oidc_config (client_secret))`
: The OAuth 2.0 client secret. This parameter is required if you are creating a rule. If you are modifying a rule, you can omit this parameter if you set `UseExistingClientSecret` to true.

`default_actions (authenticate_oidc_config (session_cookie_name))`
: The name of the cookie used to maintain session information. The default is AWSELBAuthSessionCookie.

`default_actions (authenticate_oidc_config (scope))`
: The set of user claims to be requested from the IdP. The default is `openid`. To verify which scope values your IdP supports and how to separate multiple values, see the documentation for your IdP.

`default_actions (authenticate_oidc_config (session_timeout))`
: The maximum duration of the authentication session, in seconds. The default is 604800 seconds (7 days).

`default_actions (authenticate_oidc_config (authentication_request_extra_params))`
: The query parameters (up to 10) to include in the redirect request to the authorization endpoint.

`default_actions (authenticate_oidc_config (on_unauthenticated_request))`
: The behavior if the user is not authenticated. The following are possible values are demy or allow or authenticate.

`default_actions (authenticate_oidc_config (use_existing_client_secret))`
: Indicates whether to use the existing client secret when modifying a rule. If you are creating a rule, you can omit this parameter or set it to `false`.

`default_actions (authenticate_oidc_config (user_pool_arn))`
: The Amazon Resource Name (ARN) of the Amazon Cognito user pool.

`default_actions (authenticate_oidc_config (user_pool_client_id))`
: The ID of the Amazon Cognito user pool client.

`default_actions (authenticate_oidc_config (user_pool_domain))`
: The domain prefix or fully-qualified domain name of the Amazon Cognito user pool.

`default_actions (authenticate_oidc_config (session_cookie_name))`
: The name of the cookie used to maintain session information. The default is `AWSELBAuthSessionCookie`.

`default_actions (authenticate_oidc_config (scope))`
: The set of user claims to be requested from the IdP. The default is `openid`. To verify which scope values your IdP supports and how to separate multiple values, see the documentation for your IdP.

`default_actions (authenticate_oidc_config (session_timeout))`
: The maximum duration of the authentication session, in seconds. The default is `604800` seconds (7 days).

`default_actions (authenticate_oidc_config (authentication_request_extra_params))`
: The query parameters (up to 10) to include in the redirect request to the authorization endpoint.

`default_actions (authenticate_oidc_config (authentication_request_extra_params))`
: group.

`default_actions (authenticate_oidc_config (on_unauthenticated_request))`
: The behavior if the user is not authenticated. Possible values: `deny`, `allow`, or `authenticate`.

`default_actions (order)`
: The order for the action. This value is required for rules with multiple actions. The action with the lowest value for order is performed first.

`default_actions (redirect_config (protocol))`
: The protocol. You can specify `HTTP`, `HTTPS`, or `#{protocol}`.

`default_actions (redirect_config (port))`
: The port. You can specify a value from 1 to 65535 or `#{port}`.

`default_actions (redirect_config (host))`
: The hostname. This component is not percent-encoded. The hostname can contain `#{host}`.

`default_actions (redirect_config (path))`
: The absolute path, starting with the leading "/". This component is not percent-encoded. The path can contain `#{host}`, `#{path}`, and `#{port}`.

`default_actions (redirect_config (query))`
: The query parameters, URL-encoded when necessary, but not percent-encoded. Do not include the leading "?", as it is automatically added. You can specify any of the reserved keywords.

`default_actions (redirect_config (status_code))`
: The HTTP redirect code. The redirect is either permanent (HTTP 301) or temporary (HTTP 302).

`default_actions (fixed_response_config (message_body))`
: The message.

`default_actions (fixed_response_config (status_code))`
: The HTTP response code (2XX, 4XX, or 5XX).

`default_actions (fixed_response_config (content_type))`
: The content type. Valid Values: `text/plain`, `text/css`, `text/html`, `application/javascript`, `application/json`.

`default_actions (forward_config (target_groups))`
: One or more target groups. For Network Load Balancers, you can specify a single target group.

`default_actions (forward_config (target_groups (target_group_arn)))`
: The Amazon Resource Name (ARN) of the target group.

`default_actions (forward_config (target_groups (weight)))`
: The weight. The range is 0 to 999.

`default_actions (forward_config (target_group_stickiness_config (enabled)))`
: Indicates whether target group stickiness is enabled.

`default_actions (forward_config (target_group_stickiness_config (duration_seconds)))`
: The time period, in seconds, during which requests from a client should be routed to the same target group. The range is 1-604800 seconds (7 days).

`alpn_policy`
: [TLS listener] The name of the Application-Layer Protocol Negotiation (ALPN) policy.

## Examples

**Ensure that a listener arn exists.**

```ruby
describe aws_elasticloadbalancingv2_listener(listener_arn: "LISTENER_ARN") do
  its('listener_arn') { should eq "LISTENER_ARN" }
end
```

**Ensure that listener listens to a specific port.**

```ruby
describe aws_elasticloadbalancingv2_listener(listener_arn: "LISTENER_ARN") do
  its('port') { should eq PORT_NUMBER}
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_elasticloadbalancingv2_listener(listener_arn: "LISTENER_ARN") do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="ElasticLoadBalancingV2:Client:DescribeListenersOutput" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon Auto Scaling Groups](https://docs.aws.amazon.com/autoscaling/ec2/userguide/control-access-using-iam.html).
