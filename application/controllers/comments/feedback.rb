
module TalkUp

    class Api < Roda 
        
        route('feedback', 'comment') do |routing|

            routing.post do

                data = JsonRequestBody.parse_sym(routing.body.read)
                data[:username] = @auth_account.username
                result = CommentService::AddFeedback.new.call(data)
                representer_response(result, FeedbackRepresenter)
            end
        end
    end
end