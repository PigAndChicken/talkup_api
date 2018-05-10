require 'base64'
require 'rbnacl/libsodium'

# Security Primitives for Database
class SecureDB
  # Generate key for Rake tasks
  def self.generate_key
    key = RbNaCl::Random.random_bytes(RbNaCl::SecretBox.key_bytes)
    Base64.strict_encode64 key
  end
  # Call setup once to pass in config variable with DB_KEY attribute
  def self.setup(config)
    @config = config
  end
end
