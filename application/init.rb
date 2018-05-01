folders = %w[controllers]

folders.each do |folder|
    require_relative "#{folder}/init.rb"
end