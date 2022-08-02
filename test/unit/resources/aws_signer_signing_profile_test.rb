require 'helper'
require 'aws_signer_signing_profile'
require 'aws-sdk-core'

class AWSSignerSigningProfileConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSSignerSigningProfile.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSSignerSigningProfile.new(profile_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSSignerSigningProfile.new(unexpected: 9) }
  end
end

class AWSSignerSigningProfileSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_signing_profile
    mock_data = {}
    mock_data[:profile_name] = 'test1'
    mock_data[:profile_version] = 'test1'
    mock_data[:profile_version_arn] = 'test1'
    mock_data[:revocation_record] = {
      revocation_effective_from: Time.parse("2013-08-12T23:52:02Z2020-06-05T11:30:39.730000+01:00"),
      revoked_at: Time.parse("2013-08-12T23:52:02Z2020-06-05T11:30:39.730000+01:00"),
      revoked_by: 'test1'
    }
    mock_data[:signing_material] = { certificate_arn: 'test1' }
    mock_data[:platform_id] = 'test1'
    mock_data[:platform_display_name] = 'test1'
    mock_data[:signature_validity_period] = {
      value: 1,
      type: 'test1'
    }
    mock_data[:overrides] = {
      signing_configuration: {
        encryption_algorithm: 'test1',
        hash_algorithm: 'test1'
      },
      signing_image_format: 'test1'
    }
    mock_data[:signing_parameters] = {}
    mock_data[:status] = 'test1'
    mock_data[:status_reason] = 'test1'
    mock_data[:arn] = 'test1'
    mock_data[:tags] = {}
    data[:data] = [mock_data]
    data[:client] = Aws::Signer::Client
    @resp = AWSSignerSigningProfile.new(profile_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_signing_profile_exists
    assert @resp.exists?
  end

  def test_profile_name
    assert_equal(@resp.profile_name, 'test1')
  end

  def test_profile_version
    assert_equal(@resp.profile_version, 'test1')
  end

  def test_profile_version_arn
    assert_equal(@resp.profile_version_arn, 'test1')
  end

  def test_revocation_effective_from
    assert_equal(@resp.revocation_record.revocation_effective_from, Time.parse("2013-08-12T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end

  def test_revoked_at
    assert_equal(@resp.revocation_record.revoked_at, Time.parse("2013-08-12T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end

  def test_revoked_by
    assert_equal(@resp.revocation_record.revoked_by, 'test1')
  end

  def test_certificate_arn
    assert_equal(@resp.signing_material.certificate_arn, 'test1')
  end

  def test_platform_id
    assert_equal(@resp.platform_id, 'test1')
  end

  def test_value
    assert_equal(@resp.signature_validity_period.value, 1)
  end

  def test_type
    assert_equal(@resp.signature_validity_period.type, 'test1')
  end

  def test_encryption_algorithm
    assert_equal(@resp.overrides.signing_configuration.encryption_algorithm, 'test1')
  end

  def test_hash_algorithm
    assert_equal(@resp.overrides.signing_configuration.hash_algorithm, 'test1')
  end

  def test_signing_image_format
    assert_equal(@resp.overrides.signing_image_format, 'test1')
  end

  def test_signing_parameters
    assert_equal(@resp.signing_parameters, {})
  end

  def test_status
    assert_equal(@resp.status, 'test1')
  end

  def test_status_reason
    assert_equal(@resp.status_reason, 'test1')
  end

  def test_arn
    assert_equal(@resp.arn, 'test1')
  end

  def test_tags
    assert_equal(@resp.tags, {})
  end

  def test_resource_id
    refute_nil(@resp.resource_id)
    assert_equal(@resp.resource_id, 'test1')
  end
end