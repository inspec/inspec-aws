aws_ssm_patch_baseline_id = input(:aws_ssm_patch_baseline_id, value: '', description: '')
aws_ssm_patch_baseline_name = input(:aws_ssm_patch_baseline_name, value: '', description: '')

control 'aws-ssm-patch-baselines-1.0' do
  impact 1.0
  title 'Test the properties of the ssm patch baselines.'

  describe aws_ssm_patch_baselines do
    it { should exist }
  end

  describe aws_ssm_patch_baselines do
    its('baseline_ids') { should include aws_ssm_patch_baseline_id }
    its('baseline_names') { should include aws_ssm_patch_baseline_name }
    its('operating_systems') { should include 'WINDOWS' }
    its('baseline_descriptions') { should_not be_empty }
    its('default_baselines') { should include true }
  end
end
