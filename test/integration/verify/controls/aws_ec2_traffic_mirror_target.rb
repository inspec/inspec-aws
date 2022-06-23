traffic_mirror_target_id = input(:traffic_mirror_target_id, value: '', description: '')

control 'aws_ec2_traffic_mirror_target-v1.0.0' do
  impact 1.0
  title 'Describes single Traffic Mirror Target.'
  
  describe aws_ec2_traffic_mirror_target(traffic_mirror_target_id: traffic_mirror_target_id) do
    it { should exist }
    its('traffic_mirror_target_id') { should eq traffic_mirror_target_id}
  end
end