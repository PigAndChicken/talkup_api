module TalkUp

    class CommentPolicy
        
        def initialize(account, comment)
            @account = account
            @comment = comment
        end

        def can_edit?
            account_is_commenter?
        end

        def can_delete?
            account_is_commenter? || account_is_issue_owner?
        end

        def can_feedback?
            !account_is_commenter? 
        end

        def summary
            {
                can_edit: can_edit?,
                can_delete: can_delete?,
                can_feedback: can_feedback?
            }
        end

        private
        def account_is_issue_owner?
            @account.username == @comment.issue_owner.username
        end

        def account_is_commenter?
            @account.username == @comment.commenter.username
        end

        # def account_already_feedback?
        #     @comment.feedbacks.any? {|f| f.commenter.username == @account.username}
        # end

    end
    
end