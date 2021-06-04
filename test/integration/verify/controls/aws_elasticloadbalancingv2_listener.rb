aws_ebs2_lb_arn = attribute(:aws_ebs2_lb_arn, value: '', description: '')
aws_ebs2_lb_listener_arn = attribute(:aws_ebs2_lb_listener_arn, value: '', description: '')

describe aws_elasticloadbalancingv2_listener(listener_arn: aws_ebs2_lb_listener_arn) do
    it { should exist }
  end
  
  describe aws_elasticloadbalancingv2_listener(listener_arn: aws_ebs2_lb_listener_arn) do
    its('listener_arn') { should eq aws_ebs2_lb_listener_arn }
    its('load_balancer_arn') { should eq aws_ebs2_lb_arn }
    its('port') { should eq 80 }
    its('protocol') { should eq "HTTP" }
    its('certificates') { should be_empty }
    its('certificates.first.certificate_arn') { should be_empty }
    its('certificates.first.is_default') { should be_empty }
    its('ssl_policy') { should be_empty }
  
    its('default_actions') { should_not be_empty }
    its('default_actions.first.type') { should eq "forward" }
    its('default_actions.first.target_group_arn') { should eq "arn:aws:elasticloadbalancing:us-east-2:112758395563:targetgroup/test-group/bbca6ae0c7548a9d" }
    its('default_actions.first.authenticate_oidc_config.issuer') { should be_empty }
    its('default_actions.first.authenticate_oidc_config.authorization_endpoint') { should be_empty }
    its('default_actions.first.authenticate_oidc_config.token_endpoint') { should be_empty }
    its('default_actions.first.authenticate_oidc_config.user_info_endpoint') { should be_empty }
    its('default_actions.first.authenticate_oidc_config.client_id') { should be_empty }
    its('default_actions.first.authenticate_oidc_config.client_secret') { should be_empty }
    its('default_actions.first.authenticate_oidc_config.session_cookie_name') { should be_empty }
    its('default_actions.first.authenticate_oidc_config.scope') { should be_empty }
    its('default_actions.first.authenticate_oidc_config.session_timeout') { should be_empty }
    its('default_actions.first.authenticate_oidc_config.authentication_request_extra_params') { should be_empty }
    its('default_actions.first.authenticate_oidc_config.on_unauthenticated_request') { should be_empty }
    its('default_actions.first.authenticate_oidc_config.use_existing_client_secret') { should be_empty }
  
    its('default_actions.first.authenticate_cognito_config.user_pool_arn') { should be_empty }
    its('default_actions.first.authenticate_cognito_config.user_pool_client_id') { should be_empty }
    its('default_actions.first.authenticate_cognito_config.user_pool_domain') { should be_empty }
    its('default_actions.first.authenticate_cognito_config.session_cookie_name') { should be_empty }
    its('default_actions.first.authenticate_cognito_config.scope') { should be_empty }
    its('default_actions.first.authenticate_cognito_config.session_timeout') { should be_empty }
    its('default_actions.first.authenticate_cognito_config.authentication_request_extra_params') { should be_empty }
    its('default_actions.first.authenticate_cognito_config.on_unauthenticated_request') { should be_empty }
    its('default_actions.first.order') { should be_empty }
    its('default_actions.first.redirect_config.protocol') { should be_empty }
    its('default_actions.first.redirect_config.port') { should be_empty }
    its('default_actions.first.redirect_config.host') { should be_empty }
    its('default_actions.first.redirect_config.path') { should be_empty }
    its('default_actions.first.redirect_config.query') { should be_empty }
    its('default_actions.first.redirect_config.status_code') { should be_empty }
    its('default_actions.first.fixed_response_config.message_body') { should be_empty }
    its('default_actions.first.fixed_response_config.status_code') { should be_empty }
    its('default_actions.first.fixed_response_config.content_type') { should be_empty }
    its('default_actions.first.forward_config.target_groups') { should_not be_empty }
    its('default_actions.first.forward_config.target_groups.first.target_group_arn') { should eq "arn:aws:elasticloadbalancing:us-east-2:112758395563:targetgroup/test-group/bbca6ae0c7548a9d" }
    its('default_actions.first.forward_config.target_groups.first.weight') { should eq 1 }
    its('default_actions.first.forward_config.target_group_stickiness_config.enabled') { should eq false }
    its('default_actions.first.forward_config.target_group_stickiness_config.duration_seconds') { should be_empty }
    its('alpn_policy') { should be_empty }
  end
  
  describe aws_elasticloadbalancingv2_listener(listener_arn: 'dummy') do
    it { should_not exist }
  end