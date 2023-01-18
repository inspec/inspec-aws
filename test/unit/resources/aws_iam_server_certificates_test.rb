require 'helper'
require 'aws_iam_server_certificates'
require 'aws-sdk-core'

class AWSIAMServerCertificateConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSIAMServerCertificates.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSIAMServerCertificates.new('rubbish') }
  end

  def test_iam_server_certificates_non_existing_for_empty_response
    refute AWSIAMServerCertificates.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSIAMServerCertificatesHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_server_certificates
    mock_data = {}
    mock_data[:path] = 'test1'
    mock_data[:server_certificate_name] = 'test1'
    mock_data[:server_certificate_id] = 'test1'
    mock_data[:arn] = 'test1'
    mock_data[:upload_date] = Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_data[:expiration] = Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    data[:data] = { :server_certificate_metadata_list => [mock_data] }
    data[:client] = Aws::IAM::Client
    @resp = AWSIAMServerCertificates.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_iam_client_exists
    assert @resp.exist?
  end

  def test_paths
    assert_equal(@resp.paths, ['test1'])
  end

  def test_certificate_names
    assert_equal(@resp.server_certificate_names, ['test1'])
  end

  def test_server_certificate_ids
    assert_equal(@resp.server_certificate_ids, ['test1'])
  end

  def test_arns
    assert_equal(@resp.arns, ['test1'])
  end
end
