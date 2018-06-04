module TalkUp

    class IssuePolicy

        class AccountScope

            def initialize(current_account, target_account=nil)
                target_account ||= current_account
                @current_account = current_account
                @full_scope = current_account.issues
                @target_account = target_account
            end

            def viewable
                if @current_account == @target_account
                    @full_scope
                else
                    @full_scope.select do |issue|
                        includes_collaborators?(issue, @current_account)
                    end
                end
            end

            private
            def includes_collaborators?(issue, account)
                issue.collaborators.include?(account)
            end

        end
    end
    
end