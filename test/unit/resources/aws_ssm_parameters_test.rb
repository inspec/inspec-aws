require 'helper'
require 'aws_ssm_parameters'
require 'aws-sdk-ssm'

class AwsSsmParametersConstructorTest < Minitest::Test

  def test_empty_params_ok
    AwsSsmParameters.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsSsmParameters.new('rubbish') }
  end

  def test_ssm_parameter_non_existing_for_empty_response
    refute AwsSsmParameters.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsSsmParametersSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_parameters
    mock_ssm_param = {}
    mock_ssm_param[:name] = 'ssm-name'
    mock_ssm_param[:type] = "default"
    mock_ssm_param[:key_id] = "key-id-1234"
    mock_ssm_param[:last_modified_date] = Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_ssm_param[:last_modified_user] = "arn:aws:iam::123456:user/chefuser"
    mock_ssm_param[:description] = 'description-12345'
    mock_ssm_param[:version] = 1
    mock_ssm_param[:tier] = "standard"
    data[:data] = { parameters: [mock_ssm_param] }
    data[:client] = Aws::SSM::Client
    @ssm_parameter = AwsSsmParameters.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_ssm_parameter
    assert @ssm_parameter.exist?
  end

  def test_ssm_parameter_name
    assert_equal(@ssm_parameter.names, ['ssm-name'])
  end

  def test_ssm_parameter_type
    assert_equal(@ssm_parameter.types, ['default'])
  end

  def test_ssm_parameter_key_id
    assert_equal(@ssm_parameter.key_ids, ['key-id-1234'])
  end

  def test_ssm_parameter_last_modified_date
    assert_equal(@ssm_parameter.last_modified_dates, [Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")])
  end

  def test_ssm_parameter_last_modified_user
    assert_equal(@ssm_parameter.last_modified_users, ["arn:aws:iam::123456:user/chefuser"])
  end

  def test_ssm_parameter_description
    assert_equal(@ssm_parameter.descriptions, ['description-12345'])
  end

  def test_ssm_parameter_version
    assert_equal(@ssm_parameter.versions, [1])
  end

  def test_ssm_parameter_tier
    assert_equal(@ssm_parameter.tiers, ['standard'])
  end
end