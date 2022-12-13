traffic_mirror_session_id = input(:traffic_mirror_session_id, value: '', description: '')
traffic_mirror_target_id = input(:traffic_mirror_target_id, value: '', description: '')
traffic_mirror_filter_id = input(:traffic_mirror_filter_id, value: '', description: '')
network_interface_id = input(:network_interface_id, value: '', description: '')

control 'aws-ec2-traffic-mirror-sessions-1.0' do
  title 'Describes single Traffic Mirror Session.'

  describe aws_ec2_traffic_mirror_session(traffic_mirror_session_id:  traffic_mirror_session_id) do
    it { should exist }
    its('traffic_mirror_session_id') { should eq traffic_mirror_session_id }
    its('traffic_mirror_target_id') { should eq traffic_mirror_target_id }
    its('traffic_mirror_filter_id') { should eq traffic_mirror_filter_id }
    its('network_interface_id') { should eq network_interface_id }
  end
end
