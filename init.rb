folders = %w[domain]

folders.each do |folder|
    require_relative "#{folder}/init.rb"
end