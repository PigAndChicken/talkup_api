require 'sequel'

Sequel.migration do 
    change do
        alter_table(:comments) do
            add_foreign_key :issue_id, :issues
        end
    end
end