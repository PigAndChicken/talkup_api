Dir.glob("#{File.dirname(__FILE__)}/*.rb").each do |file|
    require file
end

module TalkUp
    module Repo

        def rebuild_elements(db_record)
            element = {}
            element[:owner] = data?(db_record, :owner) ? Repo::Account.rebuild_entity(db_record.owner) : nil
            element[:collaborators] = data?(db_record, :collaborators) ? rebuild_entities(db_record.collaborators, Repo::Account) : nil
            element[:commenter] = data?(db_record, :commenter) ? Repo::Account.rebuild_entity(db_record.commenter) : nil
            element[:comments] = data?(db_record, :comments) ? rebuild_entities(db_record.comments, Repo::Comment) : nil
            element[:feedbacks] = data?(db_record, :feedbacks) ? rebuild_entities(db_record.feedbacks, Repo::Feedback) : nil
            element
        end

        private 
        def data?(db_record, method)
            db_record.methods.include?(method) && ( db_record.send(method) != nil )            
        end

        def rebuild_entities(db_record, repo)
            db_record.map! do |record|
                repo.rebuild_entity(record)
            end
            db_record
        end
    end
end