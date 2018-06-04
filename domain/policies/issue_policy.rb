module TalkUp
    
    class IssuePolicy
    
        def initialize(account, issue)
            @account = account
            @issue = issue
        end

        def can_view?
            account_is_owner? || account_is_collaborators?
        end

        def can_comment?
            account_is_collaborators? || account_is_owner?
        end

        def can_comment_anonymously?
            can_comment? && issue_anonymous?
        end

        def can_edit?
            account_is_owner?
        end

        def can_delete?
            account_is_owner?
        end
        
        def can_add_collaborators?
            account_is_owner?
        end

        def can_remove_collaborators?
            account_is_owner?
        end

        def can_leave?
            account_is_collaborators?
        end

        def comments 
            @account.comments.select {|c| c.issue.id == @issue.id}.map {|c| c.id}
        end

        def summary
            {
                can_view: can_view?,
                can_comment: can_comment?,
                can_comment_anonymously: can_comment_anonymously?,
                can_edit: can_edit?,
                can_delete: can_delete?,
                can_add_collaborators: can_add_collaborators?,
                can_remove_collaborators: can_remove_collaborators?,
                can_leave: can_leave?,
                comments: comments 
            }
        end
        

        private 

        def account_is_owner?
            @issue.owner.username == @account.username
        end

        def account_is_collaborators?
            @issue.collaborators.include?(@account)
        end

        def issue_anonymous?
            @issue.anonymous == 1
        end

    end
end