module Admin
  module Gutentag
    class TagsController < Admin::ApplicationController
      # To customize the behavior of this controller,
      # you can overwrite any of the RESTful actions. For example:
      #
      def index
        super
        @resources = ::Gutentag::Tag.page(params[:page]).per(10)
      end

      # Define a custom finder by overriding the `find_resource` method:
      private def find_resource(id)
        ::Gutentag::Tag.find(id)
      end

      # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
      # for more information
    end
  end
end
