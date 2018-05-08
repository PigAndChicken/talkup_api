require 'sequel'

Sequel.migration do 
    change do
        create_join_table(collaborator_id: :accounts, issue_id: :issues)
    end
end