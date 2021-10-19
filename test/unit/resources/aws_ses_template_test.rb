require 'helper'
require 'aws_ses_template'
require 'aws-sdk-core'

class AWSSESTemplateConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSSESTemplate.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSSESTemplate.new(template_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSSESTemplate.new(unexpected: 9) }
  end
end

class AWSSESTemplateSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_template
    mock_data = {}
    mock_data[:template_name] = 'test1'
    mock_data[:subject_part] = 'test1'
    mock_data[:text_part] = 'test1'
    mock_data[:html_part] = 'test1'
    data[:data] = { template: mock_data }
    data[:client] = Aws::SES::Client
    @resp = AWSSESTemplate.new(template_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_template
    assert @resp.exists?
  end

  def test_template_name
    assert_equal(@resp.template_name, 'test1')
  end

  def test_subject_part
    assert_equal(@resp.subject_part, 'test1')
  end

  def test_text_part
    assert_equal(@resp.text_part, 'test1')
  end

  def test_html_part
    assert_equal(@resp.html_part, 'test1')
  end
end
