aws_ssm_patch_baseline_id = input(:aws_ssm_patch_baseline_id, value: '', description: '')
aws_ssm_patch_baseline_name = input(:aws_ssm_patch_baseline_name, value: '', description: '')

control 'aws-ssm-patch-baseline-1.0' do
  title 'Test the properties of the ssm patch baseline.'

  describe aws_ssm_patch_baseline(baseline_id: aws_ssm_patch_baseline_id) do
    it { should exist }
  end

  describe aws_ssm_patch_baseline(baseline_id: aws_ssm_patch_baseline_id) do
    its('baseline_id') { should eq aws_ssm_patch_baseline_id }
    its('name') { should eq aws_ssm_patch_baseline_name }
    its('operating_system') { should eq 'WINDOWS' }

    its('global_filters.patch_filters') { should be_empty }
    its('patch_filter_keys') { should be_empty }
    its('patch_filter_values') { should be_empty }

    its('approval_rules.patch_rules') { should be_empty }
    its('patch_filter_group_keys') { should be_empty }
    its('patch_filter_group_values') { should be_empty }

    its('compliance_levels') { should be_empty }
    its('approve_after_days') { should be_empty }
    its('approve_until_dates') { should be_empty }
    its('enable_non_securities') { should be_empty }

    its('approved_patches') { should include 'KB123456' }
    its('approved_patches_compliance_level') { should eq 'UNSPECIFIED' }
    its('approved_patches_enable_non_security') { should eq false }
    its('rejected_patches') { should be_empty }
    its('rejected_patches_action') { should eq 'ALLOW_AS_DEPENDENCY' }
    its('patch_groups') { should be_empty }
    its('description') { should be_empty }

    its('sources') { should be_empty }
    its('source_names') { should be_empty }
    its('source_products') { should be_empty }
    its('source_configurations') { should be_empty }
  end
end
