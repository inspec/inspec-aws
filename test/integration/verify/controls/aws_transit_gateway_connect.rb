control 'aws_transit_gateway_connect' do
  impact 1.0
  title 'Describes one or more Connect attachments.'

  describe aws_transit_gateway_connect(transit_gateway_attachment_ids: '') do
    it { should exist }
  end

  describe aws_transit_gateway_connect(transit_gateway_attachment_ids: '') do
    its('transit_gateway_attachment_id') { should eq '' }
    its('transport_transit_gateway_attachment_id') { should eq '' }
    its('transit_gateway_id') { should eq '' }
    its('state') { should eq 'available' }
    its('options.protocol') { should eq 'gre' }
    its('tags') { should_not be_empty }
  end
end