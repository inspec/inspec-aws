aws_ebs2_lb_arn = input(:aws_ebs2_lb_arn, value: '', description: '')
aws_ebs2_lb_listener_arn = input(:aws_ebs2_lb_listener_arn, value: '', description: '')

control 'aws-elbv2-listener-1.0' do
  impact 1.0
  title 'Ensure AWS ELBv2 listener has the correct properties.'
  
  describe aws_elasticloadbalancingv2_listener(listener_arn: aws_ebs2_lb_listener_arn) do
    it { should exist }
  end
  
  describe aws_elasticloadbalancingv2_listener(listener_arn: aws_ebs2_lb_listener_arn) do
    its('listener_arn') { should eq aws_ebs2_lb_listener_arn }
    its('load_balancer_arn') { should eq aws_ebs2_lb_arn }
    its('port') { should eq 80 }
    its('protocol') { should eq 'HTTP' }
    its('certificates') { should be_empty }
    its('certificates.first.certificate_arn') { should be_empty }
    its('certificates.first.is_default') { should be_empty }
    its('ssl_policy') { should be_empty }
  
    its('default_actions') { should_not be_empty }
    its('default_actions.first.type') { should eq 'fixed-response' }
    its('default_actions.first.authenticate_oidc_config.scope') { should be_empty }
    its('default_actions.first.authenticate_oidc_config.session_timeout') { should be_empty }
    its('default_actions.first.authenticate_oidc_config.authentication_request_extra_params') { should be_empty }
    its('default_actions.first.authenticate_oidc_config.on_unauthenticated_request') { should be_empty }
    its('default_actions.first.authenticate_oidc_config.use_existing_client_secret') { should be_empty }
    its('default_actions.first.authenticate_cognito_config.user_pool_arn') { should be_empty }
    its('default_actions.first.authenticate_cognito_config.user_pool_client_id') { should be_empty }
    its('default_actions.first.authenticate_cognito_config.user_pool_domain') { should be_empty }

    its('default_actions.first.forward_config.target_group_stickiness_config.duration_seconds') { should be_empty }
    its('alpn_policy') { should be_empty }
  end
  
  describe aws_elasticloadbalancingv2_listener(listener_arn: 'dummy') do
    it { should_not exist }
  end
end