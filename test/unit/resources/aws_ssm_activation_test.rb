require 'helper'
require 'aws_ssm_activation'
require 'aws-sdk-ssm'

class AwsSsmActivationConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsSsmActivation.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AwsSsmActivation.new(activation_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsSsmActivation.new(unexpected: 9) }
  end

end

class AwsSsmActivationSuccessPathTest < Minitest::Test
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
    @ssm_activation = AwsSsmActivation.new(activation_id: 'activation-id-123465434', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_resource_id
    refute_nil(@ssm_activation.resource_id)
    assert_equal(@ssm_activation.resource_id, @ssm_activation.activation_id)
  end

  def test_ssm_activation_exists
    assert @ssm_activation.exists?
  end

  def test_ssm_activation_id
    assert_equal(@ssm_activation.activation_id, 'activation-id-123465434')
  end

  def test_ssm_activation_description
    assert_equal(@ssm_activation.description, 'activation-description')
  end

  def test_ssm_activation_default_instance_name
    assert_equal(@ssm_activation.default_instance_name, 'instance-name')
  end

  def test_ssm_activation_iam_role
    assert_equal(@ssm_activation.iam_role, 'iam-role-432')
  end

  def test_ssm_activation_expiration_date
    assert_equal(@ssm_activation.expiration_date, Time.parse("2013-08-12T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end

  def test_ssm_activation_expired
    assert_equal(@ssm_activation.expired, false)
  end

  def test_ssm_activation_created_date
    assert_equal(@ssm_activation.created_date, Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end
end
