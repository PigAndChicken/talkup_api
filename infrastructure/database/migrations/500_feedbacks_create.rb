require 'sequel'

Sequel.migration do
  change do
    create_table(:feedbacks) do
      primary_key :id
      foreign_key :comment_id, table: :comments
      foreign_key :owner_id, table: :accounts
      foreign_key :description_id, table: :feedback_descriptions

      String :content, null: false
      DateTime :create_at
      DateTime :update_at
    end
  end
end
