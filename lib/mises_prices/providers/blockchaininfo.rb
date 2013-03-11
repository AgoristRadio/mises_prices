#encoding: UTF-8
require 'httparty'
require 'socksify'
require 'json'
module MisesPrices


  class BlockchaininfoDummy
    def get
      JSON.parse(data)
    end
    def data
'{
"USD" : {"15m" : 47.42627, "last" : 47.42627, "buy" : 47.34657, "sell" : 47.42627, "24h" : 45.67, "symbol" : "$"},
"CNY" : {"15m" : 262.87202, "last" : 262.87202, "buy" : 288.35332, "sell" : 287.84343, "24h" : 262.87, "symbol" : "¥"},
"JPY" : {"15m" : 4600.858, "last" : 4600.858, "buy" : 4444.003, "sell" : 4600.858, "24h" : 4508.04, "symbol" : "¥"},
"SGD" : {"15m" : 55.7696, "last" : 55.7696, "buy" : 57.82656, "sell" : 56.74581, "24h" : 55.77, "symbol" : "$"},
"HKD" : {"15m" : 342.47641, "last" : 342.47641, "buy" : 359.51151, "sell" : 349.72174, "24h" : 342.48, "symbol" : "$"},
"CAD" : {"15m" : 47.76651, "last" : 47.76651, "buy" : 47.71686, "sell" : 47.76651, "24h" : 47.19, "symbol" : "$"},
"AUD" : {"15m" : 46.69779, "last" : 46.69779, "buy" : 46.2, "sell" : 46.69779, "24h" : 45.09, "symbol" : "$"},
"NZD" : {"15m" : 54.97653, "last" : 54.97653, "buy" : 55.86908, "sell" : 57.88283, "24h" : 54.96, "symbol" : "$"},
"GBP" : {"15m" : 31.14518, "last" : 31.14518, "buy" : 30.91656, "sell" : 31.2, "24h" : 30.38, "symbol" : "£"},
"DKK" : {"15m" : 256.17108, "last" : 256.17108, "buy" : 263.89913, "sell" : 273.38628, "24h" : 256.17, "symbol" : "kr"},
"SEK" : {"15m" : 284.256, "last" : 284.256, "buy" : 294.821, "sell" : 305.156, "24h" : 284.26, "symbol" : "kr"},
"BRL" : {"15m" : 101.3, "last" : 101.3, "buy" : 101.3, "sell" : 101.3, "24h" : 101.3, "symbol" : "R$"},
"CHF" : {"15m" : 42.67134, "last" : 42.67134, "buy" : 43.83241, "sell" : 43.5277, "24h" : 42.22, "symbol" : "CHF"},
"EUR" : {"15m" : 36.33, "last" : 36.33, "buy" : 35.9, "sell" : 36.33, "24h" : 35.11, "symbol" : "€"},
"RUB" : {"15m" : 1384.49846, "last" : 1384.49846, "buy" : 1422.75748, "sell" : 1396.81176, "24h" : 1370.81, "symbol" : "RUB"},
"SLL" : {"15m" : 11771.61, "last" : 11771.61, "buy" : 11771.61, "sell" : 11771.61, "24h" : 11771.61, "symbol" : "L$"},
"PLN" : {"15m" : 148.0, "last" : 148.0, "buy" : 146.62452, "sell" : 148.0, "24h" : 144.68, "symbol" : "zł"},
"THB" : {"15m" : 1004.96875, "last" : 1004.96875, "buy" : 1379.55486, "sell" : 1258.05999, "24h" : 1004.97, "symbol" : "฿"}
}'
    end
  end

  class BlockchaininfoNet
    def get
      Socksify::debug = true
      #@url = 'http://blockchain.info:443/ticker'
      #@url = 'http://blockchain.info/ticker'
      @url = 'http://91.203.74.203/ticker'
      @socks_host = '127.0.0.1'
      @socks_port = 8085
      turn_socksify_on

      @data = get_data
    end

    def get_data
      HTTParty.get(@url)
    end

    def turn_socksify_on
      TCPSocket::socks_server = @socks_host
      TCPSocket::socks_port = @socks_port
    end

    def turn_tor_socksify_off
      TCPSocket::socks_server = nil
      TCPSocket::socks_port = nil
    end
  end

  class Blockchaininfo

    def initialize(data_source)
      @data = data_source.get
    end

    def help
      ['blockchain.info: "15m" is the 15 minutes delayed market price, "24h" is the 24 hour average market price, "symbol" is the currency symbol.',
       "currencies  | List all currency prices provided. i.e. USD, EUR",
       "quote_types  | List all quote types available for each currency. i.e. Last, 24h",
       "quote currency [type=all]  | Get a quote for a currency, type optional.",
       "quote_human currency | Get a nice human string for a currency. Good for IRC/XMPP etc."
      ]
    end

    def currencies
      @data.each_key.collect { |key| key }
    end

    def quote_types
      @data.first[1].keys
    end

    def quote(currency, type=nil)
      if type == nil
        @data[currency]
      else
        @data[currency][type]
      end
    end

    def quote_with_symbol(currency, type=nil)
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
        "#{symbol}#{@data[currency][type]}"
      end
    end

    def quote_human(currency)
      symbol = @data[currency]['symbol']
      buy, hour24, last, minute15, sell = make_pretty_prices(currency, symbol)
      "BTC %s%s: LAST %s, 15m %s, 24h %s, BUY %s, SELL %s | blockchain.info" % [symbol, currency, last, minute15, hour24, buy, sell]
    end

    private

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