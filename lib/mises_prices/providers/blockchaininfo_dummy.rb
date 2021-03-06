#encoding: UTF-8

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
end