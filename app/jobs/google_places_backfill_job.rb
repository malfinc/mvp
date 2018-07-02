class GooglePlacesBackfillJob < ApplicationJob
  sidekiq_options queue: "google_places"

  def perform(establishment_id)
    establishment = Establishment.friendly.find(establishment_id)

    Rails.logger.info("Fetching spot #{establishment.google_places_id} from Google Places API")
    spot = GOOGLE_PLACES_CLIENT.spot(establishment.google_places_id)

    establishment.update_attributes!(
      :name => spot.name,
      :google_place => GooglePlaceResult.serialize(spot)
    )
  end
end
