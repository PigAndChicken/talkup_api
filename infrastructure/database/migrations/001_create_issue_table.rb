require 'sequel'

Sequel.migration do
    change do 
        create_table(:issues) do
            uuid :id, primary_key: true

            String :title, uniqle: true, null: false
            String :description, null: false
            Integer :process, default: 1
            Integer :section, null: false

            DateTime :created_at
            DateTime :updated_at
            DateTime :deadline
            
        end
    end
end