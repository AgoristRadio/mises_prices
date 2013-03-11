require 'spec_helper'

describe "Blockchaininfo Provider" do
  before(:all) do
    # Real net api call and return data
    #data_source = nil

    # Dummy data
    data_source = :dummy

    #@provider = MisesPrices::blockchaininfo.factory(data_source)
    @provider = MisesPrices::blockchaininfo(data_source)
  end


  it 'should list help everything it help' do
    @provider.help.first.should match("blockchain.info")
  end

  it 'should list all currencies' do
    @provider.quote_currencies.should include('USD')
    @provider.quote_currencies.should include('EUR')
  end

  it "should list all quote types" do
    @provider.quote_types.should include('24h')
  end

  it "should give error on quote request with non existent currency" do
    @provider.quote("XXX", '24h').should include("Invalid Currency")
    @provider.quote("XXX").should include('Invalid Currency')
  end

  it "should give error on quote request with invalid quote type" do
    @provider.quote(:USD, 'xr24h').should include("Invalid Quote Type")
  end

  it "should give quotes" do
    @provider.quote("USD", '24h').should_not == nil
    @provider.quote("USD", '24hdsfasgasg').should include("Invalid Quote Type")
    @provider.quote("USD").should include('24h')
  end

  it "should give quotes with lower case currency" do
    @provider.quote("usd").should include('24h')
  end

  it "should give quotes with symbol as currency" do
    @provider.quote(:USD).should include('24h')
  end

  it "should give quotes with lowercase symbol as currency" do
    @provider.quote(:usd).should include('24h')
  end

  it "should give quotes with symbols" do
    @provider.quote_with_symbol("USD", '24h').should match('$')
    @provider.quote_with_symbol("USD").first[1].should match('$')
    @provider.quote_with_symbol("usd", '24h').should match('$')
    @provider.quote_with_symbol("usd").first[1].should match('$')
    @provider.quote_with_symbol(:usd, '24h').should match('$')
    @provider.quote_with_symbol(:USD).first[1].should match('$')
  end

  it "should give pretty human quotes" do
    @provider.quote_human("USD").should match(/LAST/)
    @provider.quote_human("EUR").should match(/LAST/)
    @provider.quote_human("usd").should match(/LAST/)
    @provider.quote_human(:USD).should match(/LAST/)
    @provider.quote_human(:eur).should match(/LAST/)
  end

  it "should give error on human quote request with non existent currency" do
    @provider.quote_human("XXX").should include('Invalid Currency')
  end

end