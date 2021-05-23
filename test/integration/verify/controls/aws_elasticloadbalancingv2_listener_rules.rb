describe aws_elasticloadbalancingv2_listener_rules(rule_arns: 'arn:aws:elasticloadbalancing:us-east-2:112758395563:listener-rule/app/test1/4d099ca3e6de545d/299700e6bf77345e/360958cfddddc00d') do
    it { should exist }
  end
  
  describe aws_elasticloadbalancingv2_listener_rules(rule_arns: 'arn:aws:elasticloadbalancing:us-east-2:112758395563:listener-rule/app/test1/4d099ca3e6de545d/299700e6bf77345e/360958cfddddc00d') do
      its('rule_arns') { should include "arn:aws:elasticloadbalancing:us-east-2:112758395563:listener-rule/app/test1/4d099ca3e6de545d/299700e6bf77345e/360958cfddddc00d" }
      its('priorities') { should include "1" }
      its('conditions') { should_not be_empty }
      its('actions') { should_not be_empty }
      its('is_defaults') { should include false}
  end