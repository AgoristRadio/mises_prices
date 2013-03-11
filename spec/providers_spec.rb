require 'spec_helper'

describe "MisesPrices::providers" do
  it 'should list the all price providers' do
    MisesPrices::providers.should include('blockchaininfo')
  end
end