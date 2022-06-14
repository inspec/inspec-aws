require 'helper'
require 'aws_emr_security_configuration'
require 'aws-sdk-core'
require_relative 'mock/aws_emr_security_configuration_mock'

class AwsEmrClusterSecurityConfigurationAtRestEncryptionEnabledPathTest < Minitest::Test
  def setup
    stub_data = AwsEmrClusterSecurityConfigurationMock.new.stub_data(StubDataType::AT_REST_ENCRYPTION_ENABLED)
    @cluster = AwsEmrClusterSecurityConfiguration.new(security_configuration_name: 'sample-security-config',
                                 client_args: { stub_responses: true },
                                 stub_data: stub_data)
  end

  def test_encryption_at_rest_enabled
    assert_equal(@cluster.encryption_at_rest, true)
  end
end

class AwsEmrClusterSecurityConfigurationAtRestEncryptionDisabledPathTest < Minitest::Test
  def setup
    @cluster = AwsEmrClusterSecurityConfiguration.new(security_configuration_name: 'j-27SM4YJB3YVPL',
                                 client_args: { stub_responses: true },
                                 stub_data: AwsEmrClusterSecurityConfigurationMock.new.stub_data(StubDataType::AT_REST_ENCRYPTION_DISBALED))
  end

  def test_encryption_at_rest_disabled
    assert_equal(@cluster.encryption_at_rest, false)
  end
end

class AwsEmrClusterSecurityConfigurationInTransitEncryptionEnabledPathTest < Minitest::Test
  def setup
    @cluster = AwsEmrClusterSecurityConfiguration.new(security_configuration_name: 'j-27SM4YJB3YVPL',
                                 client_args: { stub_responses: true },
                                 stub_data: AwsEmrClusterSecurityConfigurationMock.new.stub_data(StubDataType::IN_TRANSIT_ENCRYPTION_ENABLED))
  end

  def test_encryption_in_transit_enabled
    assert_equal(@cluster.encryption_in_transit, true)
  end
end

class AwsEmrClusterSecurityConfigurationInTransitEncryptionDisabledPathTest < Minitest::Test
  def setup
    @cluster = AwsEmrClusterSecurityConfiguration.new(security_configuration_name: 'j-27SM4YJB3YVPL',
                                 client_args: { stub_responses: true },
                                 stub_data: AwsEmrClusterSecurityConfigurationMock.new.stub_data(StubDataType::IN_TRANSIT_ENCRYPTION_DISABLED))
  end

  def test_encryption_in_transit_disabled
    assert_equal(@cluster.encryption_in_transit, false)
  end
end

class AwsEmrClusterSecurityConfigurationLocalDiskEncryptionEnabledPathTest < Minitest::Test
  def setup
    @cluster = AwsEmrClusterSecurityConfiguration.new(security_configuration_name: 'j-27SM4YJB3YVPL',
                                 client_args: { stub_responses: true },
                                 stub_data: AwsEmrClusterSecurityConfigurationMock.new.stub_data(StubDataType::LOCAL_DISK_ENCRYPTION_ENABLED))
  end

  def test_encryption_local_disk_enabled
    assert_equal(@cluster.local_disk_encryption, true)
  end

  def test_resource_id
    refute_nil(@cluster.resource_id)
    assert_equal(@cluster.resource_id, 'j-27SM4YJB3YVPL')
  end
end
