require 'base64'
require 'rbnacl/libsodium'

module Securable

    def generate_key
        key = RbNaCl::Random.random_bytes(RbNaCl::SecretBox.key_bytes)
        Base64.strict_encode64(key)
    end

    def setup(config)
        @config = config
    end

    def key
        @key ||= Base64.strict_decode64(@config.DB_KEY)
    end 

    def base_encrypt(plaintext)
        simple_box = RbNaCl::SimpleBox.from_secret_key(key)
        simple_box.encrypt(plaintext)
    end

    def base_decrypt(ciphertext)
        simple_box = RbNaCl::SimpleBox.from_secret_key(key)
        simple_box.decrypt(ciphertext)
    end
    
end