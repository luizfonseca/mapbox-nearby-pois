require 'sinatra'
require "sinatra/json"
require 'mapbox-sdk'

ENDPOINTS_PATH = './endpoint'.freeze

set :port, 3300
set :bind, '0.0.0.0'
set :content_type, :json

# Setup MapBox for Geocoding features
Mapbox.access_token = ENV.fetch('MAPBOX_ACCESS_TOKEN', nil)

# Require all endpoint files that extend sinatra
Dir.children(ENDPOINTS_PATH).each do |file|
  require_relative "#{ENDPOINTS_PATH}/#{file}"
end

use Endpoint::NearbyPointsOfInterest
