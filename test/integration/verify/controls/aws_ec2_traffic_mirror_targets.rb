traffic_mirror_target_id = input(:traffic_mirror_target_id, value: '', description: '')

control 'aws-ec2-traffic-mirror-targets-1.0' do
  title 'Describes single Traffic Mirror Target.'
    
  describe aws_ec2_traffic_mirror_targets do
    it { should exist }
    its('traffic_mirror_target_ids') { should include traffic_mirror_target_id}
  end
end
