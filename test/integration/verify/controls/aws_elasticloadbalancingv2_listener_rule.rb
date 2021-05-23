describe aws_elasticloadbalancingv2_listener_rule(rule_arns: 'arn:aws:elasticloadbalancing:us-east-2:112758395563:listener-rule/app/test1/4d099ca3e6de545d/299700e6bf77345e/360958cfddddc00d') do
    it { should exist }
  end
  
  describe aws_elasticloadbalancingv2_listener_rule(rule_arns: 'arn:aws:elasticloadbalancing:us-east-2:112758395563:listener-rule/app/test1/4d099ca3e6de545d/299700e6bf77345e/360958cfddddc00d') do
      its('rule_arn') { should eq "arn:aws:elasticloadbalancing:us-east-2:112758395563:listener-rule/app/test1/4d099ca3e6de545d/299700e6bf77345e/360958cfddddc00d" }
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