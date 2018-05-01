require 'base64'
require 'rbncal/libsodium'

class SecureDB

    def self.generate_key
        key = RbNaCl::Random.random_bytes(RbNaCl::SecretBox.key_bytes)
        Base64.strict_encode64(key)
    end

    def self.setup(config)
        @config = config
    end

    def self.key
        @key ||= Base64.strict_encode64(@config.DB_KEY)
    end

    def self.encrypt(plaintext)
        
    end

end