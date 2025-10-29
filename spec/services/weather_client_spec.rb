require "rails_helper"

RSpec.describe WeatherClient, type: :service do
  before { allow(ENV).to receive(:[]).with("WEATHERAPI_KEY").and_return("testkey") }

  it "fetches and caches forecast" do
    stubbed = {
      "location" => { "name" => "Test City", "region" => "", "country" => "Testland", "lat" => 1.0, "lon" => 2.0 },
      "current" => { "temp_c" => 20.5, "temp_f" => 68.9, "condition" => { "text" => "Sunny" } }
    }

    stub_request(:get, /api.weatherapi.com/).to_return(status: 200, body: stubbed.to_json)

    key = "weather:zip:12345"
    result = described_class.fetch_for(key, address: "12345")

    expect(result[:current_temp_c]).to eq(20.5)
    expect(result[:condition]).to eq("Sunny")
    expect(result[:from_cache]).to be(false)

    # second call should be from cache
    second = described_class.fetch_for(key, address: "12345")
    expect(second[:from_cache]).to be(true)
  end
end
