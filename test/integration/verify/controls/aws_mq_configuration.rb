configuration_id = input(:configuration_id, value: '', description: 'configuration_id of AWS MQ')
configuration_arn = input(:configuration_arn, value: '', description: 'configuration_arn of AWS MQ')

title 'Test a AWS MQ Configuration.'

control 'aws_mq_configuration-1.0' do
  title 'Ensure AWS MQ Broker has the correct properties.'

  describe aws_mq_configuration(configuration_id: configuration_id) do
    it { should exist }
    its('arns') { should eq configuration_arn }
    its('description') { should eq 'test_configuration'  }
    its('ids') { should eq configuration_id }
    its('engine_types') { should eq 'ActiveMQ'  }
  end
end
