class GooglePlacesBackfillJob < ApplicationJob
  sidekiq_options queue: "google_places"

  def perform(establishment_id)
    establishment = Establishment.friendly.find(establishment_id)

    Rails.logger.info("Fetching spot #{establishment.google_places_id} from Google Places API")
    spot = GOOGLE_PLACES_CLIENT.spot(establishment.google_places_id)

    establishment.update_attributes!(
      :name => spot.name,
      :google_place => {
        :types => spot.types,
        :phone_number => spot.formatted_phone_number,
        :address => spot.formatted_address,
        :rating => spot.rating,
        :website => spot.website,
        :opening_hours => spot.opening_hours,
        :photos => spot.photos.first(3).map {|photo| photo.fetch_url(512)}
      }
    )
  end
end
