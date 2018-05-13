require 'sequel'

Sequel.migration do 
    change do
        create_table(:accounts_issues) do
            foreign_key :collaborator_id, table: :accounts
            foreign_key :issue_id, table: :issues, type: :uuid
            primary_key [:collaborator_id, :issue_id]
            index [:collaborator_id, :issue_id]
        end
    end
end