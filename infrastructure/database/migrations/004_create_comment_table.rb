require 'sequel'

Sequel.migration do
    change do 
        create_table(:comments) do
            uuid :id, primary_key: true
            foreign_key :issue_id, table: :issues, tpye: :uuid
            foreign_key :commenter_id, table: :accounts

            String :content_secure, null: false

            DateTime :created_at
            DateTime :updated_at
            
        end
    end
end