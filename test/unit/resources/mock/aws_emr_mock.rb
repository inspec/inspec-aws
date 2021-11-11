require_relative 'aws_base_resource_mock'

class AwsEmrMock < AwsBaseResourceMock
  attr_accessor :cluster_id, :cluster_state, :cluster_arn

  def initialize
    super

    @mock_cluster = {
      id: 'j-27SM4YJB3YVPL',
      status: { state: 'RUNNING' },
      cluster_arn: 'cluster-arn',
    }

    @mock_cluster_sec_config_at_rest_encryption_enabled = {}
    @mock_cluster_sec_config_at_rest_encryption_enabled[:name] = 'sec_config_at_rest_encryption_enabled'
    @mock_cluster_sec_config_at_rest_encryption_enabled[:security_configuration] = '
    {
      "EncryptionConfiguration": {
        "EnableInTransitEncryption": false,
        "EnableAtRestEncryption": true,
        "AtRestEncryptionConfiguration": {
          "S3EncryptionConfiguration": {
            "EncryptionMode": "SSE-S3"
          }
        }
      }
    }'

    @mock_cluster_sec_config_at_rest_encryption_disabled = {}
    @mock_cluster_sec_config_at_rest_encryption_disabled[:name] = 'sec_config_at_rest_encryption_disabled'
    @mock_cluster_sec_config_at_rest_encryption_disabled[:security_configuration] = '
    {
      "EncryptionConfiguration": {
        "EnableInTransitEncryption": false,
        "EnableAtRestEncryption": false
      }
    }'

    @mock_cluster_sec_config_in_transit_encryption_enabled = {}
    @mock_cluster_sec_config_in_transit_encryption_enabled[:name] = 'sec_config_in_transit_encryption_enabled'
    @mock_cluster_sec_config_in_transit_encryption_enabled[:security_configuration] = '
    {
      "EncryptionConfiguration": {
        "EnableInTransitEncryption": true,
        "EnableAtRestEncryption": false,
        "InTransitEncryptionConfiguration": {
          "TLSCertificateConfiguration": {
            "CertificateProviderType": "PEM",
            "S3Object": "s3://MyConfigStore/artifacts/MyCerts.zip"
          }
        }
      }
    }'

    @mock_cluster_sec_config_in_transit_encryption_disabled = {}
    @mock_cluster_sec_config_in_transit_encryption_disabled[:name] = 'sec_config_in_transit_encryption_disabled'
    @mock_cluster_sec_config_in_transit_encryption_disabled[:security_configuration] = '
    {
      "EncryptionConfiguration": {
        "EnableInTransitEncryption": false,
        "EnableAtRestEncryption": false
      }
    }'

    @mock_cluster_sec_config_local_disk_encryption_enabled = {}
    @mock_cluster_sec_config_local_disk_encryption_enabled[:name] = 'sec_config_local_disk_encryption_enabled'
    @mock_cluster_sec_config_local_disk_encryption_enabled[:security_configuration] = '
    {
      "EncryptionConfiguration": {
        "EnableInTransitEncryption": false,
        "EnableAtRestEncryption": true,
        "AtRestEncryptionConfiguration": {
          "S3EncryptionConfiguration": {
            "EncryptionMode": "SSE-S3"
          },
          "LocalDiskEncryptionConfiguration": {
            "EncryptionKeyProviderType": "AwsKms",
            "AwsKmsKey": "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012"
          }
        }
      }
    }'
  end

  def mock_cluster(cluster_id = 'j-27SM4YJB3YVPL', cluster_state = 'RUNNING', cluster_arn = 'cluster-arn')
    @mock_cluster = {
      id: cluster_id,
      status: { state: cluster_state },
      cluster_arn: cluster_arn,
    }
  end

  def stub_data_mock_cluster
    describe_cluster = {
      client: Aws::EMR::Client,
      method: 'describe_cluster',
      data: { cluster: mock_cluster },
    }
    [describe_cluster]
  end

  def stub_data(stub_type)
    security_configuration_data = ''
    case stub_type
    when StubDataType::AT_REST_ENCRYPTION_ENABLED
      security_configuration_data = @mock_cluster_sec_config_at_rest_encryption_enabled
    when StubDataType::AT_REST_ENCRYPTION_DISBALED
      security_configuration_data = @mock_cluster_sec_config_at_rest_encryption_disabled
    when StubDataType::IN_TRANSIT_ENCRYPTION_ENABLED
      security_configuration_data = @mock_cluster_sec_config_in_transit_encryption_enabled
    when StubDataType::IN_TRANSIT_ENCRYPTION_DISABLED
      security_configuration_data = @mock_cluster_sec_config_in_transit_encryption_disabled
    when StubDataType::LOCAL_DISK_ENCRYPTION_ENABLED
      security_configuration_data = @mock_cluster_sec_config_local_disk_encryption_enabled
    end

    stub_data = []
    mock_cluster_stub_data = stub_data_mock_cluster
    mock_cluster_stub_data[0][:data][:cluster][:security_configuration] = security_configuration_data[:name]
    stub_data += [mock_cluster_stub_data[0]]

    describe_security_configuration = {
      client: Aws::EMR::Client,
      method: 'describe_security_configuration',
      data:  security_configuration_data,
    }
    stub_data += [describe_security_configuration]
  end
end

module StubDataType
  SIMPLE = 0
  AT_REST_ENCRYPTION_ENABLED = 1
  AT_REST_ENCRYPTION_DISBALED = 2
  IN_TRANSIT_ENCRYPTION_ENABLED = 3
  IN_TRANSIT_ENCRYPTION_DISABLED = 4
  LOCAL_DISK_ENCRYPTION_ENABLED = 5
end
