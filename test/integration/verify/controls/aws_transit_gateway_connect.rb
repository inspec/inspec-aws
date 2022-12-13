skip_control 'aws_transit_gateway_connect' do
  title 'Describes one or more Connect attachments.'

  describe aws_transit_gateway_connect(transit_gateway_attachment_id: 'tgw-attach-1234567890') do
    it { should exist }
  end

  describe aws_transit_gateway_connect(transit_gateway_attachment_id: 'tgw-attach-1234567890') do
    its('transit_gateway_attachment_id') { should eq 'tgw-attach-1234567890' }
    its('transport_transit_gateway_attachment_id') { should eq 'tgw-attach-1234567890' }
    its('transit_gateway_id') { should eq 'tgw-1234567890' }
    its('state') { should eq 'available' }
    its('options.protocol') { should eq 'gre' }
    its('tags') { should_not be_empty }
  end
end
