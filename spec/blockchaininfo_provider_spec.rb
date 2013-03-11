
require 'spec_helper'

describe "Blockchaininfo Provider" do
  before(:all) do
    # Real net api call and return data
    data_source = MisesPrices::BlockchaininfoNet.new

    # Dummy data
    #data_source = MisesPrices::BlockchaininfoDummy.new

    @provider = MisesPrices::Blockchaininfo.new(data_source)
  end


  it 'should list help everything it help' do
    @provider.help.first.should match("blockchain.info")
  end

  it 'should list all currencies' do
    @provider.currencies.should include('USD')
    @provider.currencies.should include('EUR')
  end

  it "should list all quote types" do
    @provider.quote_types.should include('24h')
  end

  it "should give quotes" do
    @provider.quote("USD",'24h').should_not == nil
    @provider.quote("USD",'24hdsfasgasg').should == nil
    @provider.quote("USD").should include('24h')
  end

  it "should give quotes with symbols" do
    @provider.quote_with_symbol("USD",'24h').should match('$')
    @provider.quote_with_symbol("USD").first[1].should match('$')
  end

  it "should give pretty human quotes" do
    @provider.quote_human("USD").should  match(/LAST/)
    @provider.quote_human("EUR").should  match(/LAST/)
  end

end