require 'helper'
require 'aws_ram_resource_shares'
require 'aws-sdk-core'

class AWSRAMResourceSharesConstructorTest < Minitest::Test

    def test_empty_params_ok
        AWSRAMResourceShares.new(resource_owner: 'test1', client_args: { stub_responses: true })
    end

    def test_rejects_other_args
        assert_raises(ArgumentError) { AWSRAMResourceShares.new('rubbish') }
    end

    def test_metric_filters_non_existing_for_empty_response
        refute AWSRAMResourceShares.new(resource_owner: 'SELF', client_args: { stub_responses: true }).exist?
    end
end

class AWSRAMResourceSharesHappyPathTest < Minitest::Test

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
        mock_data[:feature_set] = "test1"
        data[:data] = { :resource_shares => [mock_data] }
        data[:client] = Aws::RAM::Client
        @resource_shares = AWSRAMResourceShares.new(resource_owner: 'test1', client_args: { stub_responses: true }, stub_data: [data])
    end

    def test_resources_exists
        assert @resource_shares.exist?
    end

    def test_resource_share_arns
        assert_equal(@resource_shares.resource_share_arns, ['test1'])
    end

    def test_names
        assert_equal(@resource_shares.names, ['test1'])
    end

    def test_owning_account_ids
        assert_equal(@resource_shares.owning_account_ids, ['test1'])
    end

    def test_allow_external_principals
        assert_equal(@resource_shares.allow_external_principals, [true])
    end

    def test_statuses
        assert_equal(@resource_shares.statuses, ['test1'])
    end

    def test_status_messages
        assert_equal(@resource_shares.status_messages, ['test1'])
    end

    def test_creation_times
        assert_equal(@resource_shares.creation_times, [Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")])
    end

    def test_last_updated_time
        assert_equal(@resource_shares.last_updated_times, [Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")])
    end

    def test_feature_sets
        assert_equal(@resource_shares.feature_sets, ['test1'])
    end
end