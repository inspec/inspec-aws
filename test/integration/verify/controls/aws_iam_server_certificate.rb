server_certificate_name = input(:server_certificate_name, value: '', description: '')
server_certificate_id = input(:server_certificate_id, value: '', description: '')

control 'aws_iam_server_certificate-1.0' do
  impact 1.0
  title 'Ensure the server certificate have the correct properties.'

  describe aws_iam_server_certificate(server_certificate_name: server_certificate_name) do
    it { should exist }
    its('server_certificate_name') { should eq server_certificate_name }
    its('server_certificate_id') { should eq server_certificate_id }
    its('path') { should eq '/' }
    its('arn') { should eq 'arn:aws:iam::9999999999:server-certificate/some_test_cert' }
    its('upload_date') { should eq Time.parse('2021-09-08T01:58:17Z') }
    its('expiration') { should eq Time.parse('2022-09-08T01:56:24Z') }
  end
end

