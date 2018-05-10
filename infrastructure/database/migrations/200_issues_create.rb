require 'sequel'

Sequel.migration do
  change do
    create_table(:issues) do
      primary_key :id
      foreign_key :owner_id, table: :accounts

      String :title, null: false
      String :description, null: false
      Integer :process, default: 1

      DateTime :create_at
      DateTime :update_at
      DateTime :deadline
    end
  end
end
