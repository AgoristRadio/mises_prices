# MisesPrices

## Easy to use Market Price Discovery Ruby Library.

Not exactly what Austrian Economists meant
by 'price discovery', but a great way to find prices from loads of markets
and use in your apps, IRC/XMPP bots, or even on the command line.

NOTE: Don't Use gem from ruby gems yet, not ready Yet. Packaging up etc now.
Playing with a git clone is fine.

Current Market Price Providers Implemented:

 * Blockchain.info

Future Market Price Providers:

 * MTGox, BTC-e, Vircuex
 * Bitcoin MPex, CryptoStocks
 * BitcoinCharts
 * Coinabul
 * Kitco
 * Open-Transaction Markets
 * Ripple Markets
 * Forex/Currency Markets




## TODO

 * Handle Net Exceptions

## Installation

Add this line to your application's Gemfile:

    gem 'mises_prices'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mises_prices

## Example Usage in Pry

```ruby
pry -r "./lib/mises_prices" # If you git cloned
or
pry
[1] pry(main)> require 'mises_prices' # If you are using the gem

# Lets see a list of market price providers

[1] pry(main)> MisesPrices::providers
=> ["blockchaininfo"]

# Lets use the blockchaininfo prrovider

[1] pry(main)> p = MisesPrices::blockchaininfo

# Lets see what is available

 [2] pry(main)> p.help
 => ["blockchain.info: \"15m\" is the 15 minutes delayed market price, \"24h\" is the 24 hour
 average market price, \"symbol\" is the currency symbol.",
  "currencies  | List all currency prices provided. i.e. USD, EUR",
  "quote_types  | List all quote types available for each currency. i.e. Last, 24h",
  "quote currency [type=all]  | Get a quote for a currency, type optional.",
  "quote_human currency | Get a nice human string for a currency. Good for IRC/XMPP etc."]
 [3] pry(main)> p.quote_currencies
 => ["USD","CNY","JPY","SGD","HKD","CAD","AUD","NZD","GBP","DKK","SEK","BRL","CHF","EUR",
 "RUB","SLL","PLN","THB"]
 [4] pry(main)> p.quote_types
 => ["15m", "last", "buy", "sell", "24h", "symbol"]

 # Lets get some prices

 [5] pry(main)> p.quote "USD"
 => {"15m"=>47.42627,"last"=>47.42627,"buy"=>47.34657,"sell"=>47.42627,"24h"=>45.67,"symbol"=>"$"}
 [6] pry(main)> p.quote :usd
 => {"15m"=>47.42627,"last"=>47.42627,"buy"=>47.34657,"sell"=>47.42627,"24h"=>45.67,"symbol"=>"$"}
  [7] pry(main)> p.quote :usd, 'last'
 => 47.42627
 [8] pry(main)> p.quote_human :usd
 => "BTC $USD: LAST $47.43, 15m $47.43, 24h $45.67, BUY $47.35, SELL $47.43 | blockchain.info"
 [9] pry(main)> p.quote_human :xxx
 => "Error: Invalid Currency XXX. Valid Currencies: USD, CNY, JPY, SGD, HKD, CAD, AUD, NZD, GBP, DKK, SEK, BRL, CHF, EUR, RUB, SLL, PLN, THB"
 [10] pry(main)>
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
