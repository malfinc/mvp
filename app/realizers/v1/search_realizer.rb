module V1
  class SearchRealizer < ApplicationRealizer
    type(:searches, :class_name => "Search", :adapter => :active_record)

    has(:email)
  end
end
