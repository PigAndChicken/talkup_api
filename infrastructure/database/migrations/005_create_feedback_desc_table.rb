require 'sequel'

Sequel.migration do
    change do
        create_table(:feedback_descriptions) do
            primary_key :id
            String :description, uniqle: true, null: false
        end

    end
end