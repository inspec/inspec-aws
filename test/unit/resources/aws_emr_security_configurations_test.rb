require 'helper'
require 'aws_emr_security_configurations'
require 'aws-sdk-core'
require_relative 'mock/aws_emr_security_configuration_mock'

class AwsEmrClusterSecurityConfigurationsHappyPathTest < Minitest::Test
  def setup
    mock_security_configurations = []
    mock_security_configuration1 = { name: 'sample_config_1' }
    mock_security_configurations << mock_security_configuration1
    mock_security_configuration2 = { name: 'sample_config_2' }
    mock_security_configurations << mock_security_configuration2

    data_list = {}
    data_list[:method] = :list_security_configurations
    data_list[:data] = { security_configurations: mock_security_configurations }
    data_list[:client] = Aws::EMR::Client

    mock_security_configurations_detailed = []
    mock_security_configuration_detailed1 = AwsEmrClusterSecurityConfigurationMock.new.mock_simple_security_configuration('sample_config_1')
    mock_security_configurations_detailed << mock_security_configuration_detailed1
    mock_security_configuration_detailed2 = AwsEmrClusterSecurityConfigurationMock.new.mock_simple_security_configuration('sample_config_2')
    mock_security_configurations_detailed << mock_security_configuration_detailed2

    data_describe = {}
    data_describe[:method] = :describe_security_configuration
    data_describe[:data] = mock_security_configuration_detailed1
    data_describe[:client] = Aws::EMR::Client

    @clusters = AwsEmrClusterSecurityConfigurations.new(client_args: { stub_responses: true }, stub_data: [data_list, data_describe])
  end

  def test_clusters_exists
    assert @clusters.exist?
  end

  def test_clusters_running
    assert @clusters.running?
  end
end
