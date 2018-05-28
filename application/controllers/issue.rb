

module TalkUp

    class Api < Roda
        
        route('issues') do |routing|

            routing.on String do |section|
                result = IssueService.all(section)
                representer_response(result, IssuesRepresenter) { Issues.new(result.value.message) }
            end

        end

        route('issue') do |routing|

            routing.post do 
                data = JsonRequestBody.parse_sym(routing.body.read)
                
                result=  IssueService::Create.new.call(data)
                representer_response(result, IssueRepresenter)
            end
            
            routing.on String do |issue_id|

                routing.get do
                    input = {:issue_id => issue_id, :username => @auth_account}
                    result = IssueService::Detail.new.call(input)
                    representer_response(result, IssueRepresenter)
                end

                routing.delete do
                    result = IssueService.delete(issue_id)
                    representer_response(result, IssueRepresenter)
                end
            end
         


        end

    end

end