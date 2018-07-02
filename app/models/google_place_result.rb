class GooglePlaceResult < ApplicationComputed
  attr_accessor :name
  attr_accessor :types
  attr_accessor :phone_number
  attr_accessor :address
  attr_accessor :rating
  attr_accessor :website
  attr_accessor :schedule
  attr_accessor :photos

  def self.serialize(spot)
    {
      :name => spot.name,
      :types => spot.types,
      :phone_number => spot.formatted_phone_number,
      :address => spot.formatted_address,
      :rating => spot.rating,
      :website => spot.website,
      :schedule => spot.opening_hours&.fetch("periods", []),
      :photos => spot.photos.first(3).map {|photo| photo.fetch_url(512)}
    }
  end
end
