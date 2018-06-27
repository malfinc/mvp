class EstablishmentDecorator < ApplicationDecorator
  delegate_all

  def contributors
    super.map(&:username).to_sentence
  end

  def photos
    google_place.fetch("photos")
  end

  def rating
    google_place.fetch("rating")
  end

  def google_place
    super.with_indifferent_access
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
end
