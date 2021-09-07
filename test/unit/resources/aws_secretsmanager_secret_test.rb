require 'helper'
require 'aws_secretsmanager_secret'
require 'aws-sdk-core'

class AWSSecretsManagerSecretConstructorTest < Minitest::Test

    def test_empty_params_not_ok
        assert_raises(ArgumentError) { AWSSecretsManagerSecret.new(client_args: { stub_responses: true }) }
    end

    def test_empty_param_arg_not_ok
        assert_raises(ArgumentError) { AWSSecretsManagerSecret.new(secret_id: '', client_args: { stub_responses: true }) }
    end

    def test_rejects_unrecognized_params
        assert_raises(ArgumentError) { AWSSecretsManagerSecret.new(unexpected: 9) }
    end
end

class AWSSecretsManagerSecretSuccessPathTest < Minitest::Test

    def setup
        data = {}
        data[:method] = :describe_secret
        mock_data = {}
        mock_data[:arn] = 'test1'
        mock_data[:name] = 'test1'
        mock_data[:description] = 'test1'
        mock_data[:kms_key_id] = 'test1'
        mock_data[:rotation_enabled] = true
        mock_data[:rotation_lambda_arn] = 'test1'
        mock_data[:rotation_rules] = {}
        mock_data[:last_rotated_date] = Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
        mock_data[:last_changed_date] = Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
        mock_data[:last_accessed_date] = Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
        mock_data[:deleted_date] = Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
        mock_data[:tags] = []
        mock_data[:owning_service] = 'test1'
        mock_data[:created_date] = Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
        mock_data[:primary_region] = 'test1'
        data[:data] = [mock_data]
        data[:client] = Aws::SecretsManager::Client
        @resp = AWSSecretsManagerSecret.new(secret_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
    end

    def test_secret_list_exists
        assert @resp.exists?
    end

    def test_arn
        assert_equal(@resp.arn, 'test1')
    end

    def test_name
        assert_equal(@resp.name, 'test1')
    end

    def test_description
        assert_equal(@resp.description, 'test1')
    end

    def test_kms_key_id
        assert_equal(@resp.kms_key_id, 'test1')
    end

    def test_rotation_enabled
        assert_equal(@resp.rotation_enabled, true)
    end

    def test_rotation_lambda_arn
        assert_equal(@resp.rotation_lambda_arn, 'test1')
    end

    def test_last_rotated_date
        assert_equal(@resp.last_rotated_date, Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
    end

    def test_last_changed_date
        assert_equal(@resp.last_changed_date, Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
    end

    def test_last_accessed_date
        assert_equal(@resp.last_accessed_date, Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
    end

    def test_deleted_date
        assert_equal(@resp.deleted_date, Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
    end

    def test_tags
        assert_equal(@resp.tags, {})
    end

    def test_owning_service
        assert_equal(@resp.owning_service, 'test1')
    end

    def test_created_date
        assert_equal(@resp.created_date, Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
    end

    def test_primary_region
        assert_equal(@resp.primary_region, 'test1')
    end
end