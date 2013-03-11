module MisesPrices
  class BlockchaininfoBase

    def initialize(data_source)
      @data = data_source.get
    end

    def help
      ['blockchain.info: "15m" is the 15 minutes delayed market price, "24h" is the 24 hour average market price, "symbol" is the currency symbol.',
       "quote_currencies  | List all currency prices provided. i.e. USD, EUR",
       "quote_types  | List all quote types available for each currency. i.e. Last, 24h",
       "quote currency [type=all]  | Get all quotes for a currency, type optional.",
       "quote_with_symbol currency [type=all]  | Get pretty formated price quote for a currency, type optional.",
       "quote_human currency | Get a nice human string for a currency. Good for IRC/XMPP etc."
      ]
    end

    def quote_currencies
      @data.keys
    end

    def quote_types
      @data.first[1].keys
    end

    def quote(currency, type=nil)
      currency = parse_currency(currency)
      return invalid_currency_string(currency) unless quote_currencies.include?(currency)

      if type == nil
        @data[currency]
      else
        return invalid_quote_type_string(type) unless quote_types.include?(type)
        @data[currency][type]
      end
    end

    def quote_with_symbol(currency, type=nil)
      currency = parse_currency(currency)
      return invalid_currency_string(currency) unless quote_currencies.include?(currency)

      symbol = @data[currency]['symbol']

      if type == nil
        new_data = @data[currency].dup
        old_data = @data[currency]

        old_data.each do |key, value|
          unless key == 'symbol'
            new_data[key] ="#{symbol}#{format_money(value)}"
          end
        end
        new_data

      else
        return invalid_quote_type_string(type) unless quote_types.include?(type)
        "#{symbol}#{@data[currency][type]}"
      end
    end

    def quote_human(currency)
      currency = parse_currency(currency)
      return invalid_currency_string(currency) unless quote_currencies.include?(currency)

      symbol = @data[currency]['symbol']
      buy, hour24, last, minute15, sell = make_pretty_prices(currency, symbol)
      "BTC %s%s: LAST %s, 15m %s, 24h %s, BUY %s, SELL %s | blockchain.info" % [symbol, currency, last, minute15, hour24, buy, sell]
    end

    private

    def invalid_currency_string(currency)
      "Error: Invalid Currency #{currency}. Valid Currencies: #{quote_currencies.join(", ")}"
    end

    def invalid_quote_type_string(type)
      "Error: Invalid Quote Type #{type}. Valid Quote Types: #{quote_types.join(", ")}"
    end


    def parse_currency(currency)
      if currency.class == Symbol
        currency = currency.to_s.upcase
      end
      currency.upcase
    end

    def make_pretty_prices(currency, symbol)
      last=pretty_price(currency, symbol, 'last')
      minute15=pretty_price(currency, symbol, '15m')
      hour24=pretty_price(currency, symbol, '24h')
      buy=pretty_price(currency, symbol, 'buy')
      sell=pretty_price(currency, symbol, 'sell')
      return buy, hour24, last, minute15, sell
    end

    def pretty_price(currency, symbol, type)
      "#{symbol}#{format_money(@data[currency][type])}"
    end

    def format_money(n)
      # TODO maybe should be proper money formatting gem/method here
      n.to_f.round(2)
    end

  end
end