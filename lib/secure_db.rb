require 'base64'
require 'rbnacl/libsodium'

require_relative './securable.rb'


class SecureDB
    extend Securable

    def self.new_salt
        Base64.strict_encode64(
            RbNaCl::Random.random_bytes(RbNaCl::PasswordHash::SCrypt::SALTBYTES)
        )
    end

    def self.hash_password(salt, pwd)
        oplimit = 2**20
        memlimit = 2**24   
        digest_size = 64
        digest = RbNaCl::PasswordHash.scrypt(pwd, Base64.strict_decode64(salt), oplimit, memlimit, digest_size)

        Base64.strict_encode64(digest)
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