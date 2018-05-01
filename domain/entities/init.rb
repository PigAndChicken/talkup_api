require 'dry-types'

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