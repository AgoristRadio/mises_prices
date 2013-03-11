require "mises_prices/version"

require "mises_prices/providers/blockchaininfo"
require "mises_prices/providers/blockchaininfo_base"
require "mises_prices/providers/blockchaininfo_dummy"
require "mises_prices/providers/blockchaininfo_net"

module MisesPrices

  def register_active_providers
    @providers
  end

 def self.providers
    ['blockchaininfo']
 end

end
