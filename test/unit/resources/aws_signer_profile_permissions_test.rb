require 'helper'
require 'aws_signer_profile_permissions'
require 'aws-sdk-core'

class AWSSignerProfilePermissionsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSSignerProfilePermissions.new(profile_name: 'test1', client_args: { stub_responses: true })
  end

  def test_param_arg_not_ok
    assert_raises(ArgumentError) { AWSSignerProfilePermissions.new(unexpected: 9, client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSSignerProfilePermissions.new(unexpected: 9) }
  end
end

class AWSSignerProfilePermissionsSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_profile_permissions
    mock_data = {}
    mock_data[:action] = 'test1'
    mock_data[:principal] = 'test1'
    mock_data[:statement_id] = 'test1'
    mock_data[:profile_version] = 'test1'
    data[:data] = { permissions: [mock_data] }
    data[:client] = Aws::Signer::Client
    @resp = AWSSignerProfilePermissions.new(profile_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_permissions_exists
    assert @resp.exists?
  end

  def actions
    assert_equal(@resp.actions, ['test1'])
  end

  def principals
    assert_equal(@resp.principals, ['test1'])
  end

  def statement_ids
    assert_equal(@resp.statement_ids, ['test1'])
  end

  def profile_versions
    assert_equal(@resp.profile_versions, ['test1'])
  end
end