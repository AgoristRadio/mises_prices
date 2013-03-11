require "mises_prices/version"

require "mises_prices/providers/blockchaininfo"

module MisesPrices

  def register_active_providers
    @providers
  end

 def self.providers
    ['blockchaininfo']
 end

end
