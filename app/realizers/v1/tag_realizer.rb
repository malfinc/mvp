module V1
  class TagRealizer < ApplicationRealizer
    type(:tags, :class_name => "Gutentag::Tag", :adapter => :active_record)

    has(:email)
  end
end
