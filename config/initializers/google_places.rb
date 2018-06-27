GOOGLE_PLACES_CLIENT = GooglePlaces::Client.new(ENV.fetch("GOOGLE_PLACES_API_SECRET")) unless Rails.env.test?
