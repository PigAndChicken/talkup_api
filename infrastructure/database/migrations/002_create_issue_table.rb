require 'sequel'

Sequel.migration do
    change do 
        create_table(:issues) do
            uuid :id, primary_key: true
            foreign_key :owner_id, table: :accounts

            String :title_secure, uniqle: true, null: false
            String :description_secure, null: false
            Integer :process, default: 1
            Integer :section, null: false

            DateTime :created_at
            DateTime :updated_at
            DateTime :deadline
            
        end
    end
end