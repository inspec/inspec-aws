require 'helper'
require 'aws_ssm_parameter'
require 'aws-sdk-ssm'

class AwsSsmParameterConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsSsmParameter.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AwsSsmParameter.new(name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsSsmParameter.new(unexpected: 9) }
  end

end

class AwsSsmParameterSuccessPathTest < Minitest::Test
  def setup
    data = {}
    data[:method] = :get_parameter
    mock_ssm_param = {}
    mock_ssm_param[:name] = 'ssm-name'
    mock_ssm_param[:type] = "default"
    mock_ssm_param[:value] = "default"
    mock_ssm_param[:version] = 1
    mock_ssm_param[:last_modified_date] = Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_ssm_param[:arn] = "arn:aws:ssm:string:ssmparam:default"
    data[:data] = { parameter: mock_ssm_param }
    data[:client] = Aws::SSM::Client
    @ssm_parameter = AwsSsmParameter.new(name: 'ssm-name', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_ssm_parameter_exists
    assert @ssm_parameter.exists?
  end

  def test_ssm_parameter_name
    assert_equal(@ssm_parameter.name, 'ssm-name')
  end

  def test_ssm_parameter_version
    assert_equal(@ssm_parameter.version, 1)
  end

  def test_ssm_parameter_type
    assert_equal(@ssm_parameter.type, 'default')
  end

  def test_ssm_parameter_value
    assert_equal(@ssm_parameter.value, 'default')
  end

  def test_ssm_parameter_last_modified_date
    assert_equal(@ssm_parameter.last_modified_date, Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end

  def test_db_subnet_group_arn
    assert_equal(@ssm_parameter.arn, 'arn:aws:ssm:string:ssmparam:default')
  end
end