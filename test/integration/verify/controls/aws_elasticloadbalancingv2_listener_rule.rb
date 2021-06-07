aws_elbv2_rule_arn = attribute(:aws_elbv2_rule_arn, value: '', description: '')

control 'aws-elbv2-listener-rule1-1.0' do

  impact 1.0
  title 'Ensure AWS ELBv2 Listerner Rule has the correct properties.'

  describe aws_elasticloadbalancingv2_listener_rule(rule_arns: aws_elbv2_rule_arn) do
    it { should exist }
  end
end
  
control 'aws-elbv2-listener-rule2-1.0' do

  impact 1.0
  title 'Ensure AWS ELBv2 Listerner Rule has the correct properties.'

  describe aws_elasticloadbalancingv2_listener_rule(rule_arns: aws_elbv2_rule_arn) do
      its('rule_arn') { should eq aws_elbv2_rule_arn }
      its('priority') { should eq "1" }
  
      its('conditions') { should_not be_empty }
      its('conditions.first.field') { should eq "query-string" }
      its('conditions.first.values') { should be_empty }
      its('conditions.first.host_header_config.values') { should be_empty }
      its('conditions.first.path_pattern_config.values') { should be_empty }
      its('conditions.first.http_header_config.http_header_name') { should be_empty }
      its('conditions.first.query_string_config.values') { should_not be_empty }
      its('conditions.first.query_string_config.values.first.key') { should eq "test" }
      its('conditions.first.query_string_config.values.first.value') { should eq "test" }
      its('conditions.first.http_request_method_config.values') { should be_empty }
      its('conditions.first.source_ip_config.values') { should be_empty }
  
      its('actions') { should_not be_empty }
      its('actions.first.type') { should eq "fixed-response" }
      its('actions.first.target_group_arn') { should be_empty }
      its('actions.first.authenticate_oidc_config.issuer') { should be_empty }
      its('actions.first.authenticate_oidc_config.authorization_endpoint') { should be_empty }
      its('actions.first.authenticate_oidc_config.token_endpoint') { should be_empty }
      its('actions.first.authenticate_oidc_config.user_info_endpoint') { should be_empty }
      its('actions.first.authenticate_oidc_config.client_id') { should be_empty }
      its('actions.first.authenticate_oidc_config.client_secret') { should be_empty }
      its('actions.first.authenticate_oidc_config.session_cookie_name') { should be_empty }
      its('actions.first.authenticate_oidc_config.scope') { should be_empty }
      its('actions.first.authenticate_oidc_config.session_timeout') { should be_empty }
      its('actions.first.authenticate_oidc_config.authentication_request_extra_params') { should be_empty }
      its('actions.first.authenticate_oidc_config.on_unauthenticated_request') { should be_empty }
      its('actions.first.authenticate_oidc_config.use_existing_client_secret') { should be_empty }
  
      its('actions.first.authenticate_cognito_config.user_pool_arn') { should be_empty }
      its('actions.first.authenticate_cognito_config.user_pool_client_id') { should be_empty }
      its('actions.first.authenticate_cognito_config.user_pool_domain') { should be_empty }
      its('actions.first.authenticate_cognito_config.session_cookie_name') { should be_empty }
      its('actions.first.authenticate_cognito_config.scope') { should be_empty }
      its('actions.first.authenticate_cognito_config.session_timeout') { should be_empty }
      its('actions.first.authenticate_cognito_config.authentication_request_extra_params') { should be_empty }
      its('actions.first.authenticate_cognito_config.on_unauthenticated_request') { should be_empty }
  
      its('actions.first.order') { should eq 1 }
  
      its('actions.first.redirect_config.protocol') { should be_empty }
      its('actions.first.redirect_config.port') { should be_empty }
      its('actions.first.redirect_config.host') { should be_empty }
      its('actions.first.redirect_config.path') { should be_empty }
      its('actions.first.redirect_config.query') { should be_empty }
      its('actions.first.redirect_config.status_code') { should be_empty }
  
      its('actions.first.fixed_response_config.message_body') { should eq "test" }
      its('actions.first.fixed_response_config.status_code') { should eq "503" }
      its('actions.first.fixed_response_config.content_type') { should eq "text/plain" }
  
      its('actions.first.forward_config.target_groups') { should be_empty }
      its('actions.first.forward_config.target_groups.first.target_group_arn') { should be_empty }
      its('actions.first.forward_config.target_groups.first.weight') { should be_empty }
      its('actions.first.forward_config.target_group_stickiness_config.enabled') { should be_empty }
      its('actions.first.forward_config.target_group_stickiness_config.duration_seconds') { should be_empty }
      
      its('is_default') { should eq false}
  end
end