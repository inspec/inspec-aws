require "aws_backend"

class AwsIamRoles < AwsResourceBase
  name "aws_iam_roles"
  desc "Verifies settings for a collection AWS IAM Roles."
  example "
    describe aws_iam_roles do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:role_names,  field: :role_name)
    .register_column(:role_ids,    field: :role_id)
    .register_column(:paths,       field: :path)
    .register_column(:arns,        field: :arn)
    .register_column(:create_date, field: :create_date)
    .register_column(:description, field: :description)
    .register_column(:assume_role_policy_document, field: :assume_role_policy_document)
    .register_column(:max_session_duration,        field: :max_session_duration)
    .register_column(:permissions_boundary_type,   field: :permissions_boundary_type)
    .register_column(:permissions_boundary_arn,    field: :permissions_boundary_arn)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    role_rows = []
    roles = {}
    pagination_options = {}

    loop do
      catch_aws_errors do
        roles = @aws.iam_client.list_roles(pagination_options)
        return [] if !roles || roles.empty?

        roles.roles.each do |r|
          permissions_boundary_type = nil
          permissions_boundary_arn  = nil

          if r.permissions_boundary
            permissions_boundary_type = r.permissions_boundary.permissions_boundary_type
            permissions_boundary_arn  = r.permissions_boundary.permissions_boundary_arn
          end
          role_rows += [{ role_name:   r.role_name,
                          role_id:     r.role_id,
                          path:        r.path,
                          arn:         r.arn,
                          create_date: r.create_date,
                          description: r.description,
                          assume_role_policy_document: r.assume_role_policy_document,
                          max_session_duration:        r.max_session_duration,
                          permissions_boundary_type:   permissions_boundary_type,
                          permissions_boundary_arn:    permissions_boundary_arn }]
        end
      end
      break unless roles.marker
      pagination_options = { marker: roles.marker }
    end
    @table = role_rows
  end
end
