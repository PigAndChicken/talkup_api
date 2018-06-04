require 'base64'
require_relative './securable.rb'
require_relative './json_request.rb'


class AuthToken
    extend Securable
    
    ONE_HOUR = 60 * 60
    ONE_DAY = ONE_HOUR * 24
    ONE_WEEK = ONE_DAY * 7
    ONE_MONTH = ONE_WEEK * 4
    ONE_YEAR = ONE_MONTH * 12

    class ExpiredTokenError < StandardError; end
    class InvalidTokenError < StandardError; end

    def self.create(object, expiration = ONE_WEEK )
        contents = { :payload => object, :exp => expires(expiration) }
        tokenize(contents)
    end

    def self.payload(token)
        contents = detokenize(token)
        contents
        expired?(contents) ? raise(ExpiredTokenError) : contents[:payload]
    end

    private_class_method

    def self.tokenize(message)
        return nil unless message
        message_json = message.to_json
        ciphertext = base_encrypt(message_json)
        Base64.urlsafe_encode64(ciphertext)
    end

    def self.detokenize(ciphertext64)
        return nil unless ciphertext64
        ciphertext = Base64.urlsafe_decode64(ciphertext64)
        message_json = base_decrypt(ciphertext)
        JsonRequestBody.parse_sym(message_json)
    rescue StandardError
        raise InvalidTokenError
    end

    def self.expires(expiration)
       (Time.now + expiration).to_i 
    end

    def self.expired?(contents)
        Time.now > Time.at(contents[:exp])
        rescue StandardError
        raise ExpiredTokenError
    end

end