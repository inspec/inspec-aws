aws_elbv2_rule_arn = input(:aws_elbv2_rule_arn, value: '', description: '')

control 'aws-elbv2-listener-rule-1.0' do
  title 'Ensure AWS ELBv2 Listener Rule has the correct properties.'

  describe aws_elasticloadbalancingv2_listener_rule(rule_arns: aws_elbv2_rule_arn) do
    it { should exist }
  end

  describe aws_elasticloadbalancingv2_listener_rule(rule_arns: aws_elbv2_rule_arn) do
      its('rule_arn') { should eq aws_elbv2_rule_arn }
      its('priority') { should eq '100' }
      its('conditions.first.field') { should eq 'path-pattern' }
      its('conditions.first.values') { should_not be_empty }
      its('actions.first.type') { should eq 'forward' }
      its('actions.first.authenticate_cognito_config.on_unauthenticated_request') { should be_empty }
      its('actions.first.order') { should eq 1 }
      its('actions.first.forward_config.target_group_stickiness_config.duration_seconds') { should be_empty }
      its('is_default') { should eq false}
  end
end
