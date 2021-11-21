traffic_mirror_session_id = attribute(:traffic_mirror_session_id, value: '')
traffic_mirror_target_id = attribute(:traffic_mirror_target_id, value: '')
traffic_mirror_filter_id = attribute(:traffic_mirror_filter_id, value: '')
network_interface_id = attribute(:network_interface_id, value: '')

control 'aws_ec2_traffic_mirror_sessions-v1.0.0' do

  impact 1.0
  title 'Describes single Traffic Mirror Session.'

  describe aws_ec2_traffic_mirror_sessions do
    it { should exist }
    its('traffic_mirror_session_ids')                  { should include traffic_mirror_session_id }
    its('traffic_mirror_target_ids')                   { should include traffic_mirror_target_id }
    its('traffic_mirror_filter_ids')                   { should include traffic_mirror_filter_id }
    its('network_interface_ids')                       { should include network_interface_id }
  end
end