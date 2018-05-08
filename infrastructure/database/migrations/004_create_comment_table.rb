require 'sequel'

Sequel.migration do
    change do 
        create_table(:comments) do
            uuid :id, primary_key: true
            foreign_key :issue_id, table: :issues, type: 'varchar(100)'
            foreign_key :commenter_id, table: :accounts, type: 'varchar(100)'

            String :content_secure, null: false

            DateTime :created_at
            DateTime :updated_at
            
        end
    end
end