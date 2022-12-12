skip_control 'aws_transit_gateway_connects' do
  title 'Describes one or more Connect attachments.'

  describe aws_transit_gateway_connects do
    it { should exist }
  end

  describe aws_transit_gateway_connects do
    its('transit_gateway_attachment_ids') { should include 'tgw-attach-1234567890' }
    its('transport_transit_gateway_attachment_ids') { should include 'tgw-attach-1234567890' }
    its('transit_gateway_ids') { should include 'tgw-1234567890' }
    its('states') { should include 'available' }
    its('options') { should_not be_empty }
    its('tags') { should_not be_empty }
  end
end
