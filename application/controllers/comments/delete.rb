
module TalkUp

    class Api < Roda 
        
        route('delete', 'comment') do |routing|

            routing.post do
                data = JsonRequestBody.parse_sym(routing.body.read)
                data[:username] = @auth_account
                result = CommentService::Delete.new.call(data)
                http_response = HttpResponseRepresneter.new(result.value)
                response.status = http_response.http_code
                
                {'message' => result.value.message}
            end
        end
    end
end