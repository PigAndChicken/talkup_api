require 'dry-types'
require_relative '../../lib/secure_db.rb'

module TalkUp
    module Entity

        module Types
            include Dry::Types.module
        end
    end
end

Dir.glob("#{File.dirname(__FILE__)}/*.rb").each do |file|
  require file
end