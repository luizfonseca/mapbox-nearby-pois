module Endpoint
  # Show nearby points based on specific coordinates
  class NearbyPointsOfInterest < Sinatra::Base
    TYPES = %w[poi].freeze
    ALLOWED_COUNTRY = 'DE'.freeze
    ALLOWED_CATEGORIES = %w[coffee restaurants].freeze

    get '/nearby' do
      status 200
      json postcodes: result
    end

    private

    def coordinates
      { latitude: Float(params[:lat]), longitude: Float(params[:lng]) }
    end

    def result
      @result ||= mapbox_request.map do |collection|
        points_by_postcode collection.dig('features')
      end

      @result&.first || {}
    end

    def points_by_postcode(features)
      return unless features

      @points_by_postcode ||= features.group_by do |feature|
        feature['context'].find { |ctx| postcode?(ctx) }['text']
      end
    end

    def mapbox_request
      @mapbox_request ||= Mapbox::Geocoder.geocode_forward(
        category,
        proximity: coordinates,
        types: TYPES,
        limit: 10,
        country: ALLOWED_COUNTRY
      )
    rescue StandardError
      # Log error on bugsnag/other platform
      []
    end

    def category
      return params[:category] if ALLOWED_CATEGORIES.include?(params[:category])

      ALLOWED_CATEGORIES.first
    end

    # Filter context ids (given by mapbox) that contain 'postcode.' on it
    def postcode?(context)
      context&.dig('id')&.match?(/postcode/)
    end
  end
end





