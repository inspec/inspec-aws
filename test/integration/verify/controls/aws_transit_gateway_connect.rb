control 'aws_transit_gateway_connect' do
  impact 1.0
  title 'Describes one or more Connect attachments.'

  describe aws_transit_gateway_connect(transit_gateway_attachment_ids: 'tgw-attach-0e38a3e1f87f3396c') do
    it { should exist }
  end

  describe aws_transit_gateway_connect(transit_gateway_attachment_ids: 'tgw-attach-0e38a3e1f87f3396c') do
    its('transit_gateway_attachment_id') { should eq 'tgw-attach-0e38a3e1f87f3396c' }
    its('transport_transit_gateway_attachment_id') { should eq 'tgw-attach-03a924ff49189ecb2' }
    its('transit_gateway_id') { should eq 'tgw-0e995e1955e41d44b' }
    its('state') { should eq 'available' }
    its('options.protocol') { should eq 'gre' }
    its('tags') { should_not be_empty }
  end
end