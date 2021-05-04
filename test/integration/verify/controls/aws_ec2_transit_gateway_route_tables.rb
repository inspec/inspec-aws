aws_transit_gateway_route_table_id = attribute(:aws_transit_gateway_route_table_id, default: '', description: 'The ID of the transit gateway route table.')
aws_transit_gateway_id = attribute(:aws_transit_gateway_id, default: '', description: 'The ID of the transit gateway.')
aws_state = attribute(:aws_state, default: '', description: 'The state of the route table (available | deleting | deleted | pending).')
aws_default_association_route_table = attribute(:aws_default_association_route_table, default: '', description: 'Indicates whether this is the default association route table for the transit gateway (true | false).')
aws_default_propagation_route_table = attribute(:aws_default_propagation_route_table, default: '', description: 'Indicates whether this is the default propagation route table for the transit gateway (true | false)')
aws_creation_time = attribute(:aws_creation_time, default: '', description: 'The creation time of the transit gateway route table.')
aws_tags = attribute(:aws_tags, default: '', description: 'The tags of the transit gateway route table.')

control 'aws-transit-gateway-route-tables-1.0' do
    impact 1.0
    title 'Describes one or more transit gateway route tables. By default, all transit gateway route tables are described. Alternatively, you can filter the results.'
    describe aws_ec2_transit_gateway_route_tables do
        it { should exist }
        its('count') { should be <= 100 }
        its('transit_gateway_route_table_ids') {should include aws_transit_gateway_route_table_id }
        its('transit_gateway_ids') {should include aws_transit_gateway_id }
        its('states') {should include aws_state }
        its('default_association_route_tables') {should include aws_default_association_route_table }
        its('default_propagation_route_tables') {should include aws_default_propagation_route_table }
        its('tags') { should_not be_empty }
    end
end