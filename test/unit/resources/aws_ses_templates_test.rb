require 'helper'
require 'aws_ses_templates'
require 'aws-sdk-core'

class AWSSESTemplatesConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSSESTemplates.new(client_args: { stub_responses: true })
  end

  def test_param_arg_not_ok
    assert_raises(ArgumentError) { AWSSESTemplates.new(unexpected: 9, client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSSESTemplates.new(unexpected: 9) }
  end
end

class AWSSESTemplatesSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_templates
    mock_data = {}
    mock_data[:name] = 'test1'
    mock_data[:created_timestamp] = Time.parse('2021-09-20 13:10:26.000000000 +0000')
    data[:data] = { templates_metadata: [mock_data] }
    data[:client] = Aws::SES::Client
    @resp = AWSSESTemplates.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_rule_sets_exists
    assert @resp.exists?
  end

  def names
    assert_equal(@resp.names, ['test1'])
  end

  def created_timestamps
    assert_equal(@resp.created_timestamps, ['test1'])
  end
end