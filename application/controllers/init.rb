
require_relative './app.rb'

Dir.glob("#{File.dirname(__FILE__)}/*.rb").each do |file|
  require file
end

require_relative './accounts/authenticate.rb'
require_relative './accounts/collaborators.rb'
require_relative './comments/init.rb'
require_relative './issues/init.rb'