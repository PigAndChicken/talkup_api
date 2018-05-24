folders = %w[ domain config infrastructure lib application ]

folders.each do |folder|
    require_relative "#{folder}/init.rb"
end