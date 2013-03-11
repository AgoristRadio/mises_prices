module MisesPrices
  # factory
  def self.blockchaininfo(source=nil)
    case source
      when :dummy
        # Dummy "mock" object
        data_source = MisesPrices::BlockchaininfoDummy.new
      else
        # Fully active remote network calls
        data_source = MisesPrices::BlockchaininfoNet.new
    end

    MisesPrices::BlockchaininfoBase.new(data_source)
  end
end