require 'helper'
require 'aws_ssm_document'
require 'aws-sdk-ssm'

class AwsSsmDocumentConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsSsmDocument.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AwsSsmDocument.new(name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsSsmDocument.new(unexpected: 9) }
  end

end

class AwsSsmDocumentSuccessPathTest < Minitest::Test
  def setup
    data = {}
    data[:method] = :describe_document
    mock_ssm_document = {}
    mock_ssm_document[:hash] = 'f2b00b4471e7236ddb11654c4e076473f5e493e916f09840abb229d5a07822b1'
    mock_ssm_document[:hash_type] = 'Sha256'
    mock_ssm_document[:name] = 'document-name'
    mock_ssm_document[:owner] = "Amazon"
    mock_ssm_document[:created_date] = Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_ssm_document[:status] = 'Active'
    mock_ssm_document[:document_version] = "1"
    mock_ssm_document[:description] = "Template"
    mock_ssm_document[:platform_types] = ["Linux"]
    mock_ssm_document[:document_type] = "Automation"
    mock_ssm_document[:schema_version] = "0.3"
    mock_ssm_document[:latest_version] = "1"
    mock_ssm_document[:default_version] = "1"
    mock_ssm_document[:document_format] = "YAML"
    mock_ssm_document[:tags] = []
    data[:data] = { document: mock_ssm_document }
    data[:client] = Aws::SSM::Client
    @ssm_document = AwsSsmDocument.new(name: 'document-name', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_ssm_document_exists
    assert @ssm_document.exists?
  end

  def test_ssm_document_name
    assert_equal(@ssm_document.name, 'document-name')
  end

  def test_ssm_document_owner
    assert_equal(@ssm_document.owner, 'Amazon')
  end

  def test_ssm_document_platform_types
    assert_equal(@ssm_document.platform_types, ["Linux"])
  end

  def test_ssm_document_version
    assert_equal(@ssm_document.document_version, '1')
  end

  def test_ssm_document_type
    assert_equal(@ssm_document.document_type, 'Automation')
  end

  def test_ssm_document_schema_version
    assert_equal(@ssm_document.schema_version, '0.3')
  end

  def test_ssm_document_format
    assert_equal(@ssm_document.document_format, 'YAML')
  end
end