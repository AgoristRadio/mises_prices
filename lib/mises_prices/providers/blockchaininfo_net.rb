require 'httparty'
require 'socksify'
require 'json'
module MisesPrices

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


end
