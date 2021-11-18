require 'helper'
require 'aws_signer_signing_profiles'
require 'aws-sdk-core'

class AWSSignerSigningProfilesConstructorTest < Minitest::Test

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSSignerSigningProfiles.new(unexpected: 9) }
  end
end

class AWSSignerSigningProfilesHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_signing_profiles
    mock_data = {}
    mock_data[:profile_name] = 'test1'
    mock_data[:profile_version] = 'test1'
    mock_data[:profile_version_arn] = 'test1'
    mock_data[:signing_material] = {
      certificate_arn: "test1"
    }
    mock_data[:signature_validity_period] = {}
    mock_data[:platform_id] = 'test1'
    mock_data[:platform_display_name] = 'test1'
    mock_data[:signing_parameters] = {}
    mock_data[:status] = 'test1'
    mock_data[:arn] = 'test1'
    mock_data[:tags] = {}
    data[:data] = { :profiles => [mock_data] }
    data[:client] = Aws::Signer::Client
    @resp = AWSSignerSigningProfiles.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_profile_names
    assert_equal(@resp.profile_names, ['test1'])
  end

  def test_profile_versions
    assert_equal(@resp.profile_versions, ['test1'])
  end

  def test_profile_version_arns
    assert_equal(@resp.profile_version_arns, ['test1'])
  end

  def test_platform_ids
    assert_equal(@resp.platform_ids, ['test1'])
  end

  def test_platform_display_names
    assert_equal(@resp.platform_display_names, ['test1'])
  end

  def test_signing_parameters
    assert_equal(@resp.signing_parameters, [{}])
  end

  def test_statuses
    assert_equal(@resp.statuses, ['test1'])
  end

  def test_arns
    assert_equal(@resp.arns, ['test1'])
  end

  def test_tags
    assert_equal(@resp.tags, [{}])
  end
end