

module TalkUp

    class Api < Roda
        
        route('issues') do |routing|

            routing.get do
                result = IssueService.all
                representer_response(result, IssuesRepresenter) { Issues.new(result.value.message) }
            end

        end

        route('issue') do |routing|

            routing.on String do |issue_id|

                routing.get do
                    result = IssueService.find_by(issue_id)
                    representer_response(result, IssueRepresenter)
                end

                routing.delete do
                    result = IssueService.delete(issue_id)
                    representer_response(result, IssueRepresenter)
                end
            end
            routing.post do 
                data = JsonRequestBody.parse_sym(routing.body.read)
                
                result=  IssueService::Create.new.call(data)
                representer_response(result, IssueRepresenter)
            end


        end

    end

end