require 'helper'
require 'aws_ram_resource_share'
require 'aws-sdk-core'

class AWSRAMResourceShareConstructorTest < Minitest::Test

    def test_empty_params_not_ok
        assert_raises(ArgumentError) { AWSRAMResourceShare.new(client_args: { stub_responses: true }) }
    end

    def test_empty_param_arg_not_ok
        assert_raises(ArgumentError) { AWSRAMResourceShare.new(resource_owner: '', resource_share_arn: '', client_args: { stub_responses: true }) }
    end

    def test_rejects_unrecognized_params
        assert_raises(ArgumentError) { AWSRAMResourceShare.new(unexpected: 9) }
    end
end

class AWSRAMResourceShareSuccessPathTest < Minitest::Test

    def setup
        data = {}
        data[:method] = :get_resource_shares
        mock_data = {}
        mock_data[:resource_share_arn] = 'test1'
        mock_data[:name] = 'test1'
        mock_data[:owning_account_id] = 'test1'
        mock_data[:allow_external_principals] = true
        mock_data[:status] = 'test1'
        mock_data[:status_message] = 'test1'
        mock_data[:tags] = []
        mock_data[:creation_time] = Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
        mock_data[:last_updated_time] = Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
        data[:data] = { :resource_shares => [mock_data] }
        data[:client] = Aws::RAM::Client
        @resource_shares = AWSRAMResourceShare.new(resource_owner: 'test1', resource_share_arn: 'test1', client_args: { stub_responses: true }, stub_data: [data])
    end

    def test_resources_exists
        assert @resource_shares.exist?
    end

    def test_resource_share_arn
        assert_equal(@resource_shares.resource_share_arn, 'test1')
    end

    def test_name
        assert_equal(@resource_shares.name, 'test1')
    end

    def test_owning_account_id
        assert_equal(@resource_shares.owning_account_id, 'test1')
    end

    def test_allow_external_principals
        assert_equal(@resource_shares.allow_external_principals, true)
    end

    def test_status
        assert_equal(@resource_shares.status, 'test1')
    end

    def test_status_message
        assert_equal(@resource_shares.status_message, 'test1')
    end

    def test_creation_time
        assert_equal(@resource_shares.creation_time, Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
    end

    def test_last_updated_time
        assert_equal(@resource_shares.last_updated_time, Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
    end

    def test_resource_id
        refute_nil(@resource_shares.resource_id)
        assert_equal(@resource_shares.resource_id, 'test1')
    end
end