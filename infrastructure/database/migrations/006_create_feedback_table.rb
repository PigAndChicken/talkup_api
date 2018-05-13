require 'sequel'

Sequel.migration do
    change do
        create_table(:feedbacks) do
            foreign_key :commenter_id, table: :accounts, type: :uuid
            foreign_key :comment_id, table: :comments, tpye: :uuid
            
            foreign_key :description_id, table: :feedback_descriptions
            primary_key :id


        end

    end
end