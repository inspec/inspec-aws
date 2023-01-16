require 'json'

aws_emr_security_configuration_name = input(:aws_emr_security_configuration_name, value: '', description: 'The Name of the EMR Security Configuration.')
aws_emr_security_configuration_name.gsub!('"', '')
aws_emr_security_configuration_json = input(:aws_emr_security_configuration_json, value: '', description: 'The JSON formatted Security Configuration.')
aws_emr_security_configuration_json.gsub!('EOT', '')
aws_emr_security_configuration_json.gsub!('<<', '')

parsed_json = JSON.parse(aws_emr_security_configuration_json.strip)
encryption_at_rest = !parsed_json['EncryptionConfiguration']['EnableAtRestEncryption'].nil? && parsed_json['EncryptionConfiguration']['EnableAtRestEncryption']
encryption_in_transit = !parsed_json['EncryptionConfiguration']['EnableInTransitEncryption'].nil? && parsed_json['EncryptionConfiguration']['EnableInTransitEncryption']
local_disk_encryption = !parsed_json['EncryptionConfiguration']['AtRestEncryptionConfiguration'].nil? &&
                          !parsed_json['EncryptionConfiguration']['AtRestEncryptionConfiguration']['LocalDiskEncryptionConfiguration'].nil? &&
                          !parsed_json['EncryptionConfiguration']['AtRestEncryptionConfiguration']['LocalDiskEncryptionConfiguration'].empty?

control 'aws-emr-security-configuration-1.0' do
  title 'Test single AWS EMR Security Configuration'

  describe aws_emr_security_configuration(security_configuration_name: aws_emr_security_configuration_name) do
    it { should exist }
    its('encryption_at_rest'){ should eq encryption_at_rest }
    its('encryption_in_transit'){ should eq encryption_in_transit }
    its('local_disk_encryption'){ should eq local_disk_encryption }
  end
end
