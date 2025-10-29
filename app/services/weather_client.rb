require "faraday"
require "json"

class WeatherClient
  BASE_URL = "https://api.weatherapi.com/v1"
  TTL = 30.minutes

  class << self
    # cache_key is the normalized key (zip or coord). address is used as q param to API.
    def fetch_for(cache_key, address:)
      key = normalize_key(cache_key)
      cached = Rails.cache.read(key)
      return cached.merge(from_cache: true) if cached.present?

      data = call_api(address)
      parsed = parse_current(data).merge(fetched_at: Time.current.utc)
      Rails.cache.write(key, parsed, expires_in: TTL)
      parsed.merge(from_cache: false)
    end

    private

    def normalize_key(raw)
      "weather:#{raw.to_s.downcase}"
    end

    def call_api(query)
      api_key = ENV.fetch("WEATHERAPI_KEY", nil)
      raise "Missing WEATHERAPI_KEY" if api_key.blank?

      url = "#{BASE_URL}/current.json"
      resp = Faraday.get(url, { key: api_key, q: query })
      raise "Weather API error #{resp.status}" unless resp.success?

      JSON.parse(resp.body)
    end

    def parse_current(json)
      loc = json["location"] || {}
      curr = json["current"] || {}
      {
        location_name: [loc["name"], loc["region"], loc["country"]].compact.join(", "),
        lat: loc["lat"],
        lon: loc["lon"],
        tz: loc["tz_id"],
        current_temp_c: curr["temp_c"],
        current_temp_f: curr["temp_f"],
        condition: (curr["condition"] || {})["text"],
        raw: json
      }
    end
  end
end
