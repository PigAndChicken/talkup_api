require_relative '../spec_helper.rb'


describe 'Test Issues Policy' do 

    before do 
            @vic = TalkUp::Repo::Account.create(DATA[:accounts][0])
            @shelly = TalkUp::Repo::Account.create(DATA[:accounts][1])
            vic = TalkUp::Repo::Account.new(DATA[:accounts][0][:username])
            issue = vic.create_issue(DATA[:issues][1])
            vic.add_collaborators_to(issue.id, [{username: @shelly.username}])
            @issue = TalkUp::Repo::Issue.find_by(:id, issue.id)[0]
    end

    after do 
        Repo::Account.delete(@vic.username)
        Repo::Account.delete(@shelly.username)
    end

    describe 'Test issue and account policy' do 
        it 'HAPPY: all policy return true' do 
            owner_policy = TalkUp::IssuePolicy.new(@vic, @issue)
            coll_policy = TalkUp::IssuePolicy.new(@shelly, @issue)

            _(owner_policy.can_view? && coll_policy.can_view?).must_equal true
            _(owner_policy.can_edit? && owner_policy.can_delete?).must_equal true
            _(owner_policy.can_comment? && coll_policy.can_comment?).must_equal true
            _(coll_policy.can_leave?).must_equal true
            _(owner_policy.can_add_collaborators? && owner_policy.can_remove_collaborators?).must_equal true
            _(coll_policy.can_comment_anonymously?).must_equal true
        end
    end

    describe 'Test comment and account policy' do 
        before do 
            shelly = TalkUp::Repo::Account.new(@shelly.username)
            @comment = shelly.add_comment_to(@issue.id, DATA[:comments][0]) 
        end

        it 'HAPPY: all policy return true' do
            commenter_policy = TalkUp::CommentPolicy.new(@shelly, @comment)
            issue_owner_policy = TalkUp::CommentPolicy.new(@vic, @comment)

            _(commenter_policy.can_edit? && commenter_policy.can_delete?).must_equal true
            _(issue_owner_policy.can_delete?).must_equal true   
        end
    end

end