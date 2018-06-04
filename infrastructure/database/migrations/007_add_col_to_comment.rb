require 'sequel'

Sequel.migration do
    change do
        alter_table(:comments) do
            add_column :anonymous, Integer, default: 0
        end

    end
end