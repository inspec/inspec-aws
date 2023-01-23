require 'helper'
require 'aws_iam_service_linked_role_deletion_status'
require 'aws-sdk-core'

class AWSIAMServiceLinkedRoleDeletionStatusConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSIAMServiceLinkedRoleDeletionStatus.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSIAMServiceLinkedRoleDeletionStatus.new(deletion_task_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSIAMServiceLinkedRoleDeletionStatus.new(unexpected: 9) }
  end
end

class AWSIAMServiceLinkedRoleDeletionStatusSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_service_linked_role_deletion_status
    mock_parameter = {}
    mock_parameter[:status] = 'SUCCEEDED'
    data[:data] = mock_parameter
    data[:client] = Aws::IAM::Client
    @resp = AWSIAMServiceLinkedRoleDeletionStatus.new(deletion_task_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_resource_id
    refute_nil(@resp.resource_id)
    assert_equal(@resp.resource_id, 'test1')
  end

  def test_service_linked_role_deletion_status_exists
    assert @resp.exists?
  end

  def test_status
    assert_equal(@resp.status, 'SUCCEEDED')
  end
end
