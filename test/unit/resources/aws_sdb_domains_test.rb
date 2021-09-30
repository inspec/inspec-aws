require 'helper'
require 'aws_sdb_domains'
require 'aws-sdk-core'

class AwsSDBDomainsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AwsSDBDomains.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsSDBDomains.new('rubbish') }
  end

  def test_instances_non_existing_for_empty_response
    refute AwsSDBDomains.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsSDBDomainsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_domains
    mock_instance = {}
    mock_instance[:domain_names] = ['rds-012b75749d0b5ceb5']
    data[:data] = { :db_instances => [mock_instance] }
    data[:client] = Aws::RDS::Client
    @domains = AwsSDBDomains.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_instances_exists
    assert @domains.exist?
  end

  def test_domain_names
    assert_equal(@domains.db_instance_identifiers, ['rds-012b75749d0b5ceb5'])
  end

end

