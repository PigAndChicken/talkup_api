

module TalkUp

    class Api < Roda
        
        route('issues') do |routing|

            routing.get String do |section|
                data = {data:{section: section}, username: @auth_account.username}
                result = IssueService::All.new.call(data)
                representer_response(result, IssuesRepresenter) { Issues.new(result.value.message) }
            end

            routing.get do 
                data ={data:{owner_id: @auth_account.id}, username: @auth_account.username}
                result = IssueService::All.new.call(data)
                representer_response(result, IssuesRepresenter) { Issues.new(result.value.message) }
            end
        end

        route('issue') do |routing|

            routing.on String do |issue_id|

                routing.on 'collaborators' do 
                    
                    routing.post do 
                        collaborators = JsonRequestBody.parse_sym(routing.body.read)[:collaborators]
                        input = {issue_id: issue_id, collaborators: collaborators, username: @auth_account.username}
                        puts input
                        result = IssueService::AddCollaborators.new.call(input)
                        representer_response(result, CollaboratorsRepresenter) { Collaborators.new(result.value.message) }
                    end

                    routing.delete do 
                        collaborator = JSON.parse routing.body.read
                        input = {issue_id: issue_id, collaborator: collaborator, username: @auth_account.username}
                        result = IssueService::RemoveCollaborator.new.call(input)
                        representer_response(result, CollaboratorRepresenter)  
                    end
                end

                routing.get do
                     input = {:issue_id => issue_id, :username => @auth_account.username}
                     result = IssueService::Detail.new.call(input)
                     representer_response(result, IssueRepresenter)
                end

                routing.delete do
                    input = {issue_id: issue_id, username: @auth_account.username}
                    result = IssueService::Delete.new.call(input)
                    { "message" => result.value.message}
                end

                routing.put do
                    data = JsonRequestBody.parse_sym(routing.body.read)
                    input = {issue_id: issue_id, issue_data: data, :username => @auth_account.username}
                    result = IssueService::Edit.new.call(input)
                    representer_response(result, IssueRepresenter)
                end

            end

            routing.post do 
                data = JsonRequestBody.parse_sym(routing.body.read)
                data[:username] = @auth_account.username
                result=  IssueService::Create.new.call(data)
                representer_response(result, IssueRepresenter)
            end
         


        end

    end

end