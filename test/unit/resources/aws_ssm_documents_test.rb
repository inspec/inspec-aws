require 'helper'
require 'aws_ssm_documents'
require 'aws-sdk-ssm'

class AwsSsmDocumentsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AwsSsmDocuments.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsSsmDocuments.new('rubbish') }
  end

  def test_ssm_parameter_non_existing_for_empty_response
    refute AwsSsmDocuments.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsSsmDocumentsSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_documents
    mock_ssm_document = {}
    mock_ssm_document[:name] = "document-name"
    mock_ssm_document[:owner] = "Amazon"
    mock_ssm_document[:platform_types] = ["Linux"]
    mock_ssm_document[:document_version] = "1"
    mock_ssm_document[:document_type] = "Automation"
    mock_ssm_document[:schema_version] = "0.3"
    mock_ssm_document[:document_format] = "YAML"
    mock_ssm_document[:target_type] = "/AWS::EC2::Volume"
    mock_ssm_document[:tags] = []
    data[:data] = { document_identifiers: [mock_ssm_document] }
    data[:client] = Aws::SSM::Client
    @ssm_document = AwsSsmDocuments.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_ssm_document_exists
    assert @ssm_document.exists?
  end

  def test_ssm_document_name
    assert_equal(@ssm_document.names, ['document-name'])
  end

  def test_ssm_document_owner
    assert_equal(@ssm_document.owners, ['Amazon'])
  end

  def test_ssm_document_platform_types
    assert_equal(@ssm_document.platform_types, [['Linux']])
  end

  def test_ssm_document_version
    assert_equal(@ssm_document.document_versions, ["1"])
  end

  def test_ssm_document_type
    assert_equal(@ssm_document.document_types, ['Automation'])
  end

  def test_ssm_document_schema_version
    assert_equal(@ssm_document.schema_versions, ['0.3'])
  end

  def test_ssm_document_format
    assert_equal(@ssm_document.document_formats, ['YAML'])
  end

  def test_ssm_document_target_type
    assert_equal(@ssm_document.target_types, ['/AWS::EC2::Volume'])
  end
end