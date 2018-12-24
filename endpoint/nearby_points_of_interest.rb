module Endpoint
  # Show nearby points based on specific coordinates
  class NearbyPointsOfInterest < Sinatra::Base
    TYPES = %w[poi].freeze
    ALLOWED_CATEGORIES = %w[coffee restaurants].freeze

    get '/nearby' do
      status 200
      json result.first
    end

    private

    def result
      @result ||= mapbox_request.map do |feature_collection|
        points_of_interest(feature_collection['features'])
      end
    end

    def points_of_interest(features)
      return unless features

      @points_of_interest ||= features.group_by do |feature|
        feature['context'].find do |context|
          context['id'].match?(/postcode/)
        end.dig('text')
      end
    end

    def mapbox_request
      Mapbox::Geocoder.geocode_forward(
        category,
        proximity: coordinates,
        types: TYPES,
        limit: 10,
        country: 'DE'
      )
    end

    def coordinates
      { latitude: 52.5300431, longitude: 13.4007813 }
    end

    def category
      return params[:category] if ALLOWED_CATEGORIES.include?(params[:category])

      ALLOWED_CATEGORIES.first
    end
  end
end





