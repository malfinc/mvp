module V1
  class TagRealizer < ApplicationRealizer
    type(:tags, :class_name => "Tag", :adapter => :active_record)

    has(:email)
  end
end
