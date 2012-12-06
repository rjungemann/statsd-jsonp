desc 'run the provider'
task :run do
  sh '. ./bashrc && coffee lib/statsd_jsonp.coffee config.json'
end

namespace :sample do

  desc 'run the sample app'
  task :run do
    sh '. ./bashrc && coffee lib/statsd_jsonp_app.coffee'
  end

end

