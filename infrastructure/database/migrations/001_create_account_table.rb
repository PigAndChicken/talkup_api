require 'sequel'

Sequel.migration do
    change do 
        create_table(:accounts) do
            primary_key :id

            String :username, uniqle: true, null: false
            String :email, uniqule: true, null: false
            String :password_hash
            String :salt

            DateTime :created_at
            DateTime :updated_at
            DateTime :deadline
            
        end
    end
end