folders = %w[database]

folders.each do |folder|

    require_relative "#{folder}/init.rb"

end