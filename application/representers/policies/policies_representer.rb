require_relative './issue_policy_representer.rb'

module TalkUp

    class PoliciesRepresenter < Roar::Decorator
        include Roar::JSON

        property :issue_policy, extend: IssuePolicyRepresenter

    end
    
end