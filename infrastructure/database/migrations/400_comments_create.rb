require 'sequel'

Sequel.migration do
  change do
    create_table(:comments) do
      primary_key :id
      foreign_key :issue_id, table: :issues
      foreign_key :owner_id, :table: :accounts

      String :content, null: false

      DateTime :create_at
      DateTime :update_at
    end
  end
end
