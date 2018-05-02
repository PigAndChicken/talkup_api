module TalkUp

    class HttpResponseRepresneter < Roar::Decorator
        include Roar::JSON

        property :code
        property :message

        HTTP_CODE = {
            :ok => 200,
            :created => 201,
            :accepted => 202,

            :not_found => 404,
        }
    end
end