require 'serverspec'

set :backend, :exec
Rake::load_rakefile('Rakefile')
Rake::load_rakefile('../../rakelib/Rakefile')
