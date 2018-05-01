require 'sequel'

Sequel.migration do
    change do 
        drop_column :comments, :issue_key
    end
end