require 'sequel'

Sequel.migration do
  change do
    create_table(:accounts) do
      primary_key :id

      String :username, null: false, unique: true
      String :email, null: false, unique: true
      String :identity
      String :password_hash
      String :salt

      DateTime :create_at
      DateTime :update_at
    end
  end
end
