require 'helper'
require 'aws-sdk-core'
require 'aws_cloudformation_stack'
require_relative 'mock/aws_cloudformation_stack_mock'

class AwsCloudFormationStackConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsCloudformationStack.new(client_args: { stub_responses: true }) }
  end

  def test_accepts_stack_name
    AwsCloudformationStack.new(stack_name: 'stack_name', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsCloudformationStack.new(rubbish: 9) }
  end

  def test_cf_not_existing
    refute AwsCloudformationStack.new(stack_name: 'name-not-there', client_args: { stub_responses: true }).exists?
  end
end

class AwsCloudFormationStackTest < Minitest::Test

  def setup
    # Given
    @mock = AwsCloudFormationStackMock.new
    @mock_cf = @mock.cf[:stacks].first

    # When
    @cf = AwsCloudformationStack.new(stack_name: @mock_cf[:stack_name],
                                 client_args: { stub_responses: true },
                                 stub_data: @mock.stub_data)
  end

  def test_stack_name
    assert_equal(@cf.stack_name, @mock_cf[:stack_name])
  end

  def test_stack_id
    assert_equal(@cf.stack_id, @mock_cf[:stack_id])
  end

  def test_change_set_id
    assert_equal(@cf.change_set_id, @mock_cf[:change_set_id])
  end

  def test_parameters
    assert_equal(@cf.parameters.first.parameter_key, @mock_cf[:parameters].first[:parameter_key])
  end

  def test_description
    assert_equal(@cf.description, @mock_cf[:description])
  end

  def test_creation_time
    assert_equal(@cf.creation_time, @mock_cf[:creation_time].to_s)
  end

  def test_deletion_time
    assert_equal(@cf.deletion_time.to_s, @mock_cf[:deletion_time].to_s)
  end

  def test_last_updated_time
    assert_equal(@cf.last_updated_time.to_s, @mock_cf[:last_updated_time].to_s)
  end

  def test_rollback_configuration
    assert_equal(@cf.rollback_configuration.monitoring_time_in_minutes, @mock_cf[:rollback_configuration][:monitoring_time_in_minutes])
  end

  def test_stack_status
    assert_equal(@cf.stack_status, @mock_cf[:stack_status])
  end

  def test_stack_status_reason
    assert_equal(@cf.stack_status_reason, @mock_cf[:stack_status_reason])
  end

  def test_drift_information
    assert_equal(@cf.drift_information.stack_drift_status, @mock_cf[:drift_information][:stack_drift_status])
  end

  def test_disable_rollback
    assert_equal(@cf.disable_rollback, @mock_cf[:disable_rollback])
  end

  def test_notification_arns
    assert_equal(@cf.notification_arns, @mock_cf[:notification_arns])
  end

  def test_timeout_in_minutes
    assert_equal(@cf.timeout_in_minutes, @mock_cf[:timeout_in_minutes])
  end

  def test_capabilities
    assert_equal(@cf.capabilities, @mock_cf[:capabilities])
  end

  def test_outputs
    assert_equal(@cf.outputs.first.export_name, @mock_cf[:outputs].first[:export_name])
  end

  def test_role_arn
    assert_equal(@cf.role_arn, @mock_cf[:role_arn])
  end

  def test_tags
    assert_equal(@cf.tags.first.key, @mock_cf[:tags].first[:key])
  end

  def test_enable_termination_protection
    assert_equal(@cf.enable_termination_protection, @mock_cf[:enable_termination_protection])
  end

  def test_parent_id
    assert_equal(@cf.parent_id, @mock_cf[:parent_id])
  end

  def test_root_id
    assert_equal(@cf.root_id, @mock_cf[:root_id])
  end

  def test_exists
    assert @cf.exists?
  end
end