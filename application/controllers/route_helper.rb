
module TalkUp

    class Api < Roda
        
        def representer_response(result, represneter)
            
            http_response = HttpResponseRepresneter.new(result.value)
            
            response.status = http_response.http_code

            if response.status < 300
                result_body = result.value.message
                result_body = yield if block_given?
                represneter.new(result_body).to_json
            else
                http_response.to_json
            end
        end
    end
end