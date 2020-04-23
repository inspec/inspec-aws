require_relative 'aws_base_resource_mock'

class AwsElastiCacheClusterMock < AwsBaseResourceMock
  ENCRYPTED = [true, false].freeze

  def multiple(n)
    # Create multiple Elasticache Clusters
    mocks = []
    n.times do
      mocks << {
          cache_cluster_id: @aws.any_string,
          configuration_endpoint: {
              :address => @aws.any_string,
              :port => 11211,
          },
          cache_node_type: "cache.t2.micro",
          engine: "memcached",
          engine_version: "1.5.16",
          cache_cluster_status: "available",
          num_cache_nodes: 2,
          preferred_availability_zone: "Multiple",
          cache_cluster_create_time: Time.parse(@aws.any_date.to_s),
          cache_parameter_group: {
              cache_parameter_group_name: "default.memcached1.5",
              parameter_apply_status: "in-sync",
              cache_node_ids_to_reboot: []
          },
          cache_subnet_group_name: "default",
          cache_nodes: [
              {
                  cache_node_id: "0001",
                  cache_node_status: "available",
                  cache_node_create_time: Time.parse(@aws.any_date.to_s),
                  endpoint: {
                      address: @aws.any_string,
                      port: 11211
                  },
                  parameter_group_status: "in-sync",
                  customer_availability_zone: "us-east-2a"
              },
              {
                  cache_node_id: "0002",
                  cache_node_status: "available",
                  cache_node_create_time: Time.parse(@aws.any_date.to_s),
                  endpoint: {
                      address: @aws.any_string,
                      port: 11211
                  },
                  parameter_group_status: "in-sync",
                  customer_availability_zone: "us-east-2a"
              }
          ],
          auto_minor_version_upgrade: true,
          security_groups: [
              {
                  security_group_id: "sg-1d2eb076",
                  status: "active"
              }
          ],
          auth_token_enabled: false,
          transit_encryption_enabled: true,
          at_rest_encryption_enabled: true,
      }
    end
    mocks.freeze
  end
end
