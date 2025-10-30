class WeatherController < ApplicationController
  def index
    # simple search form
  end

  def show
    address = params[:address].to_s.strip
    if address.blank?
      flash.now[:alert] = "Please provide an address (street, city or ZIP)."
      render :index and return
    end

    geocoded = Geocoder.search(address).first
    cache_key = if geocoded && geocoded.postal_code.present?
                  "weather:zip:#{geocoded.postal_code}"
                elsif geocoded && geocoded.coordinates
                  lat, lon = geocoded.coordinates
                  "weather:coord:#{lat.round(4)},#{lon.round(4)}"
                else
                  "weather:q:#{address.parameterize}"
                end

    @forecast = WeatherClient.fetch_for(cache_key, address: address)
  rescue StandardError => e
    Rails.logger.error("WeatherController#show error: #{e.message}\n#{e.backtrace.first(10).join("\n")}")
    flash.now[:alert] = "Unable to retrieve forecast at this time."
    render :index
  end
end
