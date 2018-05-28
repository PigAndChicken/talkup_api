module TalkUp

    class HttpResponseRepresneter < Roar::Decorator
        include Roar::JSON

        property :code
        property :message

        HTTP_CODE = {
            :ok => 200,
            :created => 201,
            :accepted => 202,

            :bad_request => 400,
            :unauthorized => 401,
            :not_found => 404,
            :conflict => 409,

            :internal_server_error => 500
        }

        def http_code 
            HTTP_CODE[@represented.code]
        end

        def to_json
            http_message.to_json
        end

        private

        def http_success?
            http_code < 300
        end

        def http_message
            {msg_or_error => @represented.message}
        end

        def msg_or_error
            http_success? ? :message : :errors
        end

    end
end