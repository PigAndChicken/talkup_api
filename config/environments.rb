require 'roda'
require 'econfig'

require_relative '../lib/secure_db.rb'
require_relative '../lib/auth_token.rb'

module TalkUp

    class Api < Roda
        plugin :environments

        extend Econfig::Shortcut
        Econfig.env = environment.to_s
        Econfig.root = '.'

        configure :development, :test do 
            ENV['DATABASE_URL'] = "sqlite://" + config.DB_FILENAME
        end

        configure :production do 
            require 'pg'
        end
        
        configure do 
            require 'sequel'
            DB = Sequel.connect(ENV['DATABASE_URL'])

            def self.DB
                DB
            end

            SecureDB.setup(config)
            AuthToken.setup(config)
        end

    end

end