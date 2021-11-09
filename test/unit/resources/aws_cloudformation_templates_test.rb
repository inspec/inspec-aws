require 'helper'
require 'aws_cloudformation_templates'
require 'aws-sdk-core'

class AWSCloudFormationTemplatesConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSCloudFormationTemplates.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_stack_name_arg_not_ok
    assert_raises(ArgumentError) { AWSCloudFormationTemplates.new(stack_name: '', client_args: { stub_responses: true }) }
  end

  def test_empty_param_template_url_arg_not_ok
    assert_raises(ArgumentError) { AWSCloudFormationTemplates.new(template_url: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSCloudFormationTemplates.new(unexpected: 9) }
  end
end

class AWSCloudFormationTemplatesWithParameterStackNameSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_template_summary
    mock_data = {}
    mock_data[:parameters] = []
    mock_data[:description] = 'test1'
    mock_data[:capabilities] = ['test1']
    mock_data[:capabilities_reason] = 'test1'
    mock_data[:resource_types] = ['test1']
    mock_data[:version] = 'test1'
    mock_data[:metadata] = 'test1'
    mock_data[:declared_transforms] = ['test1']
    mock_data[:resource_identifier_summaries] = []
    data[:data] = [mock_data]
    data[:client] = Aws::CloudFormation::Client
    @resp = AWSCloudFormationTemplates.new(stack_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_template_exists
    assert @resp.exists?
  end

  def test_parameters
    assert_equal(@resp.parameters, [[]])
  end

  def test_descriptions
    assert_equal(@resp.descriptions, ['test1'])
  end

  def test_capabilities
    assert_equal(@resp.capabilities, [['test1']])
  end

  def test_capabilities_reasons
    assert_equal(@resp.capabilities_reasons, ['test1'])
  end

  def test_resource_types
    assert_equal(@resp.resource_types, [['test1']])
  end

  def test_versions
    assert_equal(@resp.versions, ['test1'])
  end

  def test_metadata
    assert_equal(@resp.metadata, ['test1'])
  end

  def test_declared_transforms
    assert_equal(@resp.declared_transforms, [['test1']])
  end

  def test_resource_identifier_summaries
    assert_equal(@resp.resource_identifier_summaries, [[]])
  end
end

class AWSCloudFormationTemplatesWithParameterStackNameSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_template_summary
    mock_data = {}
    mock_data[:parameters] = []
    mock_data[:description] = 'test1'
    mock_data[:capabilities] = ['test1']
    mock_data[:capabilities_reason] = 'test1'
    mock_data[:resource_types] = ['test1']
    mock_data[:version] = 'test1'
    mock_data[:metadata] = 'test1'
    mock_data[:declared_transforms] = ['test1']
    mock_data[:resource_identifier_summaries] = []
    data[:data] = [mock_data]
    data[:client] = Aws::CloudFormation::Client
    @resp = AWSCloudFormationTemplates.new(template_url: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_template_exists
    assert @resp.exists?
  end

  def test_parameters
    assert_equal(@resp.parameters, [[]])
  end

  def test_descriptions
    assert_equal(@resp.descriptions, ['test1'])
  end

  def test_capabilities
    assert_equal(@resp.capabilities, [['test1']])
  end

  def test_capabilities_reasons
    assert_equal(@resp.capabilities_reasons, ['test1'])
  end

  def test_resource_types
    assert_equal(@resp.resource_types, [['test1']])
  end

  def test_versions
    assert_equal(@resp.versions, ['test1'])
  end

  def test_metadata
    assert_equal(@resp.metadata, ['test1'])
  end

  def test_declared_transforms
    assert_equal(@resp.declared_transforms, [['test1']])
  end

  def test_resource_identifier_summaries
    assert_equal(@resp.resource_identifier_summaries, [[]])
  end
end