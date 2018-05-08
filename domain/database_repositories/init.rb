Dir.glob("#{File.dirname(__FILE__)}/*.rb").each do |file|
    require file
end

module TalkUp
    module Repo

        def rebuild_elements(db_record)
            element = {}
            element[:owner] = Repo::Account.rebuild_entity(db_record.owner) if db_record.methods.include?(:owner)
            element[:commenter] = Repo::Account.rebuild_entity(db_record.commenter) if db_record.methods.include?(:commenter)
            element[:issues] = db_record.issues.map {|issue| Repo::Issue.rebuild_entity(issue)} if db_record.methods.include?(:issues)
            element[:comments] = db_record.comments.map {|comment| Repo::Comment.rebuild_entity(comment)} if db_record.methods.include?(:comments)
            element
        end
    end
end