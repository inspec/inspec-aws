require 'helper'
require 'aws_cloudformation_template'
require 'aws-sdk-core'

class AWSCloudFormationTemplateConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSCloudFormationTemplate.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_stack_name_arg_not_ok
    assert_raises(ArgumentError) { AWSCloudFormationTemplate.new(stack_name: '', client_args: { stub_responses: true }) }
  end

  def test_empty_param_template_url_arg_not_ok
    assert_raises(ArgumentError) { AWSCloudFormationTemplate.new(template_url: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSCloudFormationTemplate.new(unexpected: 9) }
  end
end

class AWSCloudFormationTemplateWithParameterStackNameSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_template_summary
    mock_data = {}
    mock_data[:parameters] = [
      parameter_key: 'test1',
      default_value: 'test1',
      parameter_type: 'test1',
      no_echo: true,
      description: 'test1',
      parameter_constraints: {
        allowed_values: ['test1']
      }
    ]
    mock_data[:description] = 'test1'
    mock_data[:capabilities] = ['test1']
    mock_data[:capabilities_reason] = 'test1'
    mock_data[:resource_types] = ['test1']
    mock_data[:version] = 'test1'
    mock_data[:metadata] = 'test1'
    mock_data[:declared_transforms] = ['test1']
    mock_data[:resource_identifier_summaries] = [
      resource_type: 'test1',
      logical_resource_ids: ['test1'],
      resource_identifiers: ['test1']
    ]
    data[:data] = [mock_data]
    data[:client] = Aws::CloudFormation::Client
    @resp = AWSCloudFormationTemplate.new(stack_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_template_exists
    assert @resp.exists?
  end

  def test_parameter_key
    assert_equal(@resp.parameters[0].parameter_key, 'test1')
  end

  def test_parameters_default_value
    assert_equal(@resp.parameters[0].default_value, 'test1')
  end

  def test_parameter_type
    assert_equal(@resp.parameters[0].parameter_type, 'test1')
  end

  def test_parameters_no_echo
    assert_equal(@resp.parameters[0].no_echo, true)
  end

  def test_parameters_description
    assert_equal(@resp.parameters[0].description, 'test1')
  end

  def test_description
    assert_equal(@resp.description, 'test1')
  end

  def test_capabilities
    assert_equal(@resp.capabilities, ['test1'])
  end

  def test_capabilities_reason
    assert_equal(@resp.capabilities_reason, 'test1')
  end

  def test_resource_types
    assert_equal(@resp.resource_types, ['test1'])
  end

  def test_version
    assert_equal(@resp.version, 'test1')
  end

  def test_metadata
    assert_equal(@resp.metadata, 'test1')
  end

  def test_declared_transforms
    assert_equal(@resp.declared_transforms, ['test1'])
  end

  def test_resource_identifier_summaries_resource_type
    assert_equal(@resp.resource_identifier_summaries[0].resource_type, 'test1')
  end

  def test_resource_identifier_summaries_logical_resource_ids
    assert_equal(@resp.resource_identifier_summaries[0].logical_resource_ids, ['test1'])
  end

  def test_resource_identifier_summaries_resource_identifiers
    assert_equal(@resp.resource_identifier_summaries[0].resource_identifiers, ['test1'])
  end
end

class AWSCloudFormationTemplateWithParameterTemplateURLSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_template_summary
    mock_data = {}
    mock_data[:parameters] = [
      parameter_key: 'test1',
      default_value: 'test1',
      parameter_type: 'test1',
      no_echo: true,
      description: 'test1',
      parameter_constraints: {
        allowed_values: ['test1']
      }
    ]
    mock_data[:description] = 'test1'
    mock_data[:capabilities] = ['test1']
    mock_data[:capabilities_reason] = 'test1'
    mock_data[:resource_types] = ['test1']
    mock_data[:version] = 'test1'
    mock_data[:metadata] = 'test1'
    mock_data[:declared_transforms] = ['test1']
    mock_data[:resource_identifier_summaries] = [
      resource_type: 'test1',
      logical_resource_ids: ['test1'],
      resource_identifiers: ['test1']
    ]
    data[:data] = [mock_data]
    data[:client] = Aws::CloudFormation::Client
    @resp = AWSCloudFormationTemplate.new(template_url: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_template_exists
    assert @resp.exists?
  end

  def test_parameter_key
    assert_equal(@resp.parameters[0].parameter_key, 'test1')
  end

  def test_parameters_default_value
    assert_equal(@resp.parameters[0].default_value, 'test1')
  end

  def test_parameter_type
    assert_equal(@resp.parameters[0].parameter_type, 'test1')
  end

  def test_parameters_no_echo
    assert_equal(@resp.parameters[0].no_echo, true)
  end

  def test_parameters_description
    assert_equal(@resp.parameters[0].description, 'test1')
  end

  def test_description
    assert_equal(@resp.description, 'test1')
  end

  def test_capabilities
    assert_equal(@resp.capabilities, ['test1'])
  end

  def test_capabilities_reason
    assert_equal(@resp.capabilities_reason, 'test1')
  end

  def test_resource_types
    assert_equal(@resp.resource_types, ['test1'])
  end

  def test_version
    assert_equal(@resp.version, 'test1')
  end

  def test_metadata
    assert_equal(@resp.metadata, 'test1')
  end

  def test_declared_transforms
    assert_equal(@resp.declared_transforms, ['test1'])
  end

  def test_resource_identifier_summaries_resource_type
    assert_equal(@resp.resource_identifier_summaries[0].resource_type, 'test1')
  end

  def test_resource_identifier_summaries_logical_resource_ids
    assert_equal(@resp.resource_identifier_summaries[0].logical_resource_ids, ['test1'])
  end

  def test_resource_identifier_summaries_resource_identifiers
    assert_equal(@resp.resource_identifier_summaries[0].resource_identifiers, ['test1'])
  end
end
