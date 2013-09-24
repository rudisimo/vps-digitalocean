require "rubygems"
require "highline/import"
require "files/rake/generator"
require "files/rake/configuration"

desc "Generate a custom Vagrantfile"
task :render do
  config = Configuration.new()
  config.hostname = ask("Droplet Hostname?") { |q|
    q.default = "digitalocean-master"
  }
  config.username = ask("Droplet Username?") { |q|
    q.default = "vagrant"
  }
  config.private_key = ask("Droplet SSH Key?") { |q|
    q.default = "~/.ssh/id_rsa"
  }
  config.client_id = ask("DigitalOcean Client ID?") { |q|
    q.default = nil
  }
  config.api_key = ask("DigitalOcean API Key?") { |q|
    q.default = nil
  }

  template = File.join(File.dirname(__FILE__), "Vagrantfile.erb")
  output = File.join(File.dirname(__FILE__), "Vagrantfile")

  generator = Generator.new(config, template)
  generator.save(output)
end

task :default => ["render"]
