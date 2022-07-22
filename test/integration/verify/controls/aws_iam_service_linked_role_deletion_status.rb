skip_control 'service-linked-role-deletion-status' do
  impact 1.0
  title 'Test the deletion status of serviced linked role'
  
  describe aws_iam_service_linked_role_deletion_status(deletion_task_id: 'dummy-value') do
    it { should exist }
  end

  describe aws_iam_service_linked_role_deletion_status(deletion_task_id: 'dummy-value') do
    its('status') { should eq 'SUCCEEDED' }
  end
end

