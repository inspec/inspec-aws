require 'helper'
require 'aws_ssm_activations'
require 'aws-sdk-ssm'

class AwsSsmActivationsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AwsSsmActivations.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsSsmActivations.new('rubbish') }
  end

  def test_ssm_parameter_non_existing_for_empty_response
    refute AwsSsmActivations.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsSsmActivationsSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_activations
    mock_ssm_activation = {}
    mock_ssm_activation[:activation_id] = "activation-id-123465434"
    mock_ssm_activation[:description] = "activation-description"
    mock_ssm_activation[:default_instance_name] = "instance-name"
    mock_ssm_activation[:iam_role] = "iam-role-432"
    mock_ssm_activation[:registration_limit] = 5
    mock_ssm_activation[:expiration_date] = Time.parse("2013-08-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_ssm_activation[:expired] = false
    mock_ssm_activation[:created_date] = Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_ssm_activation[:tags] = []
    data[:data] = { activation_list: [mock_ssm_activation] }
    data[:client] = Aws::SSM::Client
    @ssm_activation = AwsSsmActivations.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_ssm_activations
    assert @ssm_activation.exist?
  end

  def test_ssm_activation_id
    assert_equal(@ssm_activation.activation_ids, ['activation-id-123465434'])
  end

  def test_ssm_activation_description
    assert_equal(@ssm_activation.descriptions, ['activation-description'])
  end

  def test_ssm_activation_default_instance_name
    assert_equal(@ssm_activation.default_instance_names, ['instance-name'])
  end

  def test_ssm_activation_iam_role
    assert_equal(@ssm_activation.iam_roles, ['iam-role-432'])
  end

  def test_ssm_activation_registration_limit
    assert_equal(@ssm_activation.registration_limits, [5])
  end

  def test_ssm_activation_expiration_date
    assert_equal(@ssm_activation.expiration_dates, [Time.parse("2013-08-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")])
  end

  def test_ssm_activation_expired
    assert_equal(@ssm_activation.expired, [false])
  end

  def test_ssm_activation_created_date
    assert_equal(@ssm_activation.created_dates, [Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00")])
  end
end