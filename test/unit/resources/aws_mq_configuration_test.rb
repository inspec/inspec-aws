require 'helper'
require 'aws_mq_configuration'
require 'aws-sdk-core'

class AWSMQConfigurationConstructorTest < Minitest::Test
  
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSMQConfiguration.new(client_args: { stub_responses: true }) }
  end
  
  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSMQConfiguration.new(configuration_id: '', client_args: { stub_responses: true }) }
  end
  
  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSMQConfiguration.new(unexpected: 9) }
  end
end

class AWSMQConfigurationSuccessPathTest < Minitest::Test
  
  def setup
    data = {}
    data[:method] = :describe_configuration
    mock_data = {}
    mock_data[:arn] = 'test_arn'
    mock_data[:authentication_strategy] = "SIMPLE"
    mock_data[:created] = Time.parse("2013-08-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_data[:description] = 'test_description'
    mock_data[:engine_type] = "ACTIVEMQ"
    mock_data[:engine_version] = 'test_engine_version'
    mock_data[:id] = 'test_id'
    mock_data[:latest_revision] = {
      created: Time.parse("2013-08-12T23:52:02Z2020-06-05T11:30:39.730000+01:00"),
      description: 'test_revision_description',
      revision: 1
    }
    mock_data[:name] = 'test_name'
    mock_data[:tags] = {}
    data[:data] = [mock_data]
    data[:client] = Aws::MQ::Client
    @res = AWSMQConfiguration.new(configuration_id: 'config_id', client_args: { stub_responses: true }, stub_data: [data])
  end
  
  def test_resource_id
    refute_nil(@res.resource_id)
    assert_equal(@res.resource_id, @res.arn)
  end
  
  def test_mq_exists
    assert @res.exists?
  end
  
  def test_arn
    assert_equal(@res.arn, 'test_arn')
  end
  
  def test_authentication_strategy
    assert_equal(@res.authentication_strategy, 'SIMPLE')
  end
  
  def test_created_date
    assert_equal(@res.created, Time.parse("2013-08-12T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end

  def test_description
    assert_equal(@res.description, 'test_description')
  end

  def test_engine_type
    assert_equal(@res.engine_type, 'ACTIVEMQ')
  end

  def test_engine_version
    assert_equal(@res.engine_version, 'test_engine_version')
  end
  
  def test_id
    assert_equal(@res.id, 'test_id')
  end

  def test_latest_revision_created_date
    assert_equal(@res.latest_revision.created, Time.parse("2013-08-12T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end

  def test_latest_revision_description
    assert_equal(@res.latest_revision.description, 'test_revision_description')
  end

  def test_latest_revision_revision
    assert_equal(@res.latest_revision.revision, 1)
  end
  
  def test_name
    assert_equal(@res.name, 'test_name')
  end
  
  def test_tags
    assert_equal(@res.tags, {})
  end
end
