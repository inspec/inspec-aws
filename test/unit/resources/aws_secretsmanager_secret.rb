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
        mock_data[:last_rotated_date] = Time.parse(1523482025.685)
        mock_data[:last_changed_date] = Time.parse(1523482025.685)
        mock_data[:last_accessed_date] = Time.parse(1523482025.685)
        mock_data[:deleted_date] = Time.parse(1523482025.685)
        mock_data[:tags] = {}
        mock_data[:secret_versions_to_stages] = {}
        mock_data[:owning_service] = 'test1'
        mock_data[:created_date] = Time.parse(1523482025.685)
        mock_data[:primary_region] = 'test1'
        data[:data] = mock_data
        data[:client] = Aws::SecretsManager::Client
        @configuration = AWSSecretsManagerSecret.new(secret_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
    end

    def test_secret_list_exists
        assert @secret_list.exists?
    end

    def test_arn
        assert_equal(@secret_list.arn, 'test1')
    end

    def test_name
        assert_equal(@secret_list.name, 'test1')
    end

    def test_description
        assert_equal(@secret_list.description, 'test1')
    end

    def test_kms_key_id
        assert_equal(@secret_list.kms_key_id, 'test1')
    end

    def test_rotation_enabled
        assert_equal(@secret_list.rotation_enabled, true)
    end

    def test_rotation_lambda_arn
        assert_equal(@secret_list.rotation_lambda_arn, 'test1')
    end

    def test_rotation_rules
        assert_equal(@secret_list.rotation_rules, {})
    end

    def test_last_rotated_date
        assert_equal(@secret_list.last_rotated_date, Time.parse(1523482025.685))
    end

    def test_last_changed_date
        assert_equal(@secret_list.last_changed_date, Time.parse(1523482025.685))
    end

    def test_last_accessed_date
        assert_equal(@secret_list.last_accessed_date, Time.parse(1523482025.685))
    end

    def test_deleted_date
        assert_equal(@secret_list.deleted_date, Time.parse(1523482025.685))
    end

    def test_tags
        assert_equal(@secret_list.tags, {})
    end

    def test_secret_versions_to_stage
        assert_equal(@secret_list.secret_versions_to_stage, {})
    end

    def test_owning_service
        assert_equal(@secret_list.owning_service, 'test1')
    end

    def test_created_date
        assert_equal(@secret_list.created_date, Time.parse(1523482025.685))
    end

    def test_primary_region
        assert_equal(@secret_list.primary_region, 'test1')
    end
end