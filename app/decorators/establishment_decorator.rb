class EstablishmentDecorator < ApplicationDecorator
  delegate_all

  def contributors
    super.map(&:username).to_sentence
  end

  def photos
    google_place.fetch("photos", [])
  end

  def rating
    google_place.fetch("rating", 0.0)
  end

  def google_place
    super.with_indifferent_access
  end
end
