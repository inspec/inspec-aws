traffic_mirror_session_id = input(:traffic_mirror_session_id, value: '', description: '')
traffic_mirror_target_id = input(:traffic_mirror_target_id, value: '', description: '')
traffic_mirror_filter_id = input(:traffic_mirror_filter_id, value: '', description: '')
network_interface_id = input(:network_interface_id, value: '', description: '')

control 'aws-ec2-traffic-mirror-session-1.0' do
  impact 1.0
  title 'Describes single Traffic Mirror Session.'

  describe aws_ec2_traffic_mirror_sessions do
    it { should exist }
    its('traffic_mirror_session_ids') { should include traffic_mirror_session_id }
    its('traffic_mirror_target_ids') { should include traffic_mirror_target_id }
    its('traffic_mirror_filter_ids') { should include traffic_mirror_filter_id }
    its('network_interface_ids') { should include network_interface_id }
  end
end