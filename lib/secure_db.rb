require 'base64'
require 'rbnacl/libsodium'


class SecureDB

    def self.generate_key
        key = RbNaCl::Random.random_bytes(RbNaCl::SecretBox.key_bytes)
        Base64.strict_encode64(key)
    end

    def self.setup(config)
        @config = config
    end

    def self.key
        @key ||= Base64.strict_decode64(@config.DB_KEY)
    end

    def self.encrypt(plaintext)
        return nil unless plaintext
        simple_box = RbNaCl::SimpleBox.from_secret_key(key)
        ciphertext = simple_box.encrypt(plaintext)
        Base64.strict_encode64(ciphertext)
    end

    def self.decrypt(ciphertext64)
        return nil unless ciphertext64
        ciphertext = Base64.strict_decode64(ciphertext64)
        simple_box = RbNaCl::SimpleBox.from_secret_key(key)
        simple_box.decrypt(ciphertext)
    end

end