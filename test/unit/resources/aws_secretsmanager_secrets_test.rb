require 'helper'
require 'aws_secretsmanager_secrets'
require 'aws-sdk-core'

class AWSSecretsManagerSecretsConstructorTest < Minitest::Test
    def test_rejects_unrecognized_params
        assert_raises(ArgumentError) { AWSSecretsManagerSecrets.new(unexpected: 9) }
    end
end

class AWSSecretsManagerSecretsSuccessPathTest < Minitest::Test

    def setup
        data = {}
        data[:method] = :list_secrets
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
        data[:data] = { secret_list: [mock_data] }
        data[:client] = Aws::SecretsManager::Client
        @secret_list = AWSSecretsManagerSecrets.new(client_args: { stub_responses: true }, stub_data: [data])
    end

    def test_secret_list_exists
        assert @secret_list.exists?
    end

    def test_arns
        assert_equal(@secret_list.arns, ['test1'])
    end

    def test_names
        assert_equal(@secret_list.names, ['test1'])
    end

    def test_descriptions
        assert_equal(@secret_list.descriptions, ['test1'])
    end

    def test_kms_key_ids
        assert_equal(@secret_list.kms_key_ids, ['test1'])
    end

    def test_rotation_lambda_arns
        assert_equal(@secret_list.rotation_lambda_arns, ['test1'])
    end

    def test_last_rotated_dates
        assert_equal(@secret_list.last_rotated_dates, [Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")])
    end

    def test_last_changed_dates
        assert_equal(@secret_list.last_changed_dates, [Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")])
    end

    def test_last_accessed_dates
        assert_equal(@secret_list.last_accessed_dates, [Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")])
    end

    def test_deleted_dates
        assert_equal(@secret_list.deleted_dates, [Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")])
    end

    def test_tags
        assert_equal(@secret_list.tags, [[]])
    end

    def test_owning_services
        assert_equal(@secret_list.owning_services, ['test1'])
    end

    def test_created_dates
        assert_equal(@secret_list.created_dates, [Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")])
    end

    def test_primary_regions
        assert_equal(@secret_list.primary_regions, ['test1'])
    end
end