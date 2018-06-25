module Admin
  module FriendlyId
    class SlugsController < Admin::ApplicationController
      # To customize the behavior of this controller,
      # you can overwrite any of the RESTful actions. For example:
      #
      def index
        super
        @resources = ::FriendlyId::Slug.page(params[:page]).per(10)
      end

      # Define a custom finder by overriding the `find_resource` method:
      private def find_resource(slug)
        ::FriendlyId::Slug.find_by(:slug => slug)
      end

      # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
      # for more information

      def valid_action?(name, resource = resource_class)
        [:show, :index].include?(name) && super
      end
    end
  end
end
