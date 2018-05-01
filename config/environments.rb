require 'roda'
require 'econfig'

require_relative '../lib/secure_db.rb'


module TalkUp

    class Api < Roda
        plugin :environments

        extend Econfig::Shortcut
        Econfig.env = environment.to_s
        Econfig.root = '.'

        configure :development, :test do 
            ENV['DATABASE_URL'] = "sqlite://" + config.DB_FILENAME
        end

        configure do 
            require 'sequel'
            DB = Sequel.connect(ENV['DATABASE_URL'])

            def self.DB
                DB
            end

            SecureDB.setup(config)
        end

    end

end