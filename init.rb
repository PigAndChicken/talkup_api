folders = 'config,domain,infrastructure,lib,spec'
Dir.glob("./{#{folders}}/init.rb").each do |file|
  require file
end
