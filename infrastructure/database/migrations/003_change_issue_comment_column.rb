require 'sequel'

Sequel.migration do
    change do 
        alter_table(:issues) do
            rename_column :title, :title_secure
            rename_column :description, :description_secure
        end

        alter_table(:comments) do
            rename_column :content, :content_secure
        end
    end
end