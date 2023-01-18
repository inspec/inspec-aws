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

control 'aws-emr-security-configurations-1.0' do
  title 'Test AWS EMR Security Configuration in bulk'

  describe aws_emr_security_configurations do
    it { should exist }
  end

  describe aws_emr_security_configurations.where(security_configuration_name: aws_emr_security_configuration_name) do
    it { should exist }
    its('encryption_at_rests') { should include encryption_at_rest }
    its('encryption_in_transits') { should include encryption_in_transit }
    its('local_disk_encryptions') { should include local_disk_encryption }
  end
end
