if Poutineer.secrets.present?
  GOOGLE_PLACES_CLIENT = GooglePlaces::Client.new(Poutineer.secrets.fetch_deep(:google_places, :secret)) unless Rails.env.test?
end
