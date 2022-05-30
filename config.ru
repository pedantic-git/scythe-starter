require 'opal'

run(Opal::SimpleServer.new do |s|
  # the name of the ruby file to load. To use more files they must be required from here (see app)
  s.main = 'application'

  # the directory where the code is (add to opal load path )
  s.append_path 'app'
end)
