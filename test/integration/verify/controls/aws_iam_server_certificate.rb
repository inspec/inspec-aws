# frozen_string_literal: true
server_certificate_name = attribute(:server_certificate_name, default: '', description: 'Name of server certificates.')
control 'aws_iam_server_certificate-1.0' do

  impact 1.0
  title 'Ensure the server certificate have the correct properties.'

  describe aws_iam_server_certificate(server_certificate_name: 'some_test_cert') do
    it { should exist }
    its('server_certificate_name') { should eq 'some_test_cert' }
    its('server_certificate_id') { should eq 'ASCARUQHMSKVS5SCDCSZ7' }
    its('path') { should eq '/' }
    its('arn') { should eq 'arn:aws:iam::112758395563:server-certificate/some_test_cert' }
    its('upload_date') { should eq Time.parse('2021-09-08T01:58:17Z') }
    its('expiration') { should eq Time.parse('2022-09-08T01:56:24Z') }
  end
end

