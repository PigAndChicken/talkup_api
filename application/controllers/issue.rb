

module TalkUp

    class Api < Roda
        
        route('issues') do |routing|

            routing.get do
                result = FindIssuesIndex.all
                representer_response(result, IssuesRepresenter) { Issues.new(result.value.message) }
            end

        end

        route('issue') do |routing|

            routing.on String do |issue_id|

                routing.get do
                    result = FindIssueDetail.find_by(issue_id)
                    representer_response(result, IssueRepresenter)
                end
            end
        end

    end

end