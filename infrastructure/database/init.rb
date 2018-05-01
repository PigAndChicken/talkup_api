folders = %w[orm]

folders.each do |folder|

    require_relative "#{folder}/init.rb"

end