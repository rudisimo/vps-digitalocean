class Configuration
  attr_accessor :hostname, :private_key, :client_id, :api_key

  def initialize()
    @hostname = "vps-digitalocean"
    @private_key = "~/.ssh/id_rsa"
    @client_id = nil
    @api_key = nil
  end
end
