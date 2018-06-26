module V1
  class ApplicationController < ::ApplicationController
    include JSONAPI::Home
    include Pundit

    before_action :set_paper_trail_whodunnit
    before_bugsnag_notify :set_bugsnag_context
    after_action :verify_authorized
    after_action :verify_policy_scoped
    before_action :ensure_account_exists
    before_action :ensure_cart_exists

    private def pundit_user
      current_account
    end

    private def user_for_paper_trail
      if account_signed_in? then current_account else "Anonymous" end
    end

    private def info_for_paper_trail
      {
        actor_id: if account_signed_in? then current_account.id end,
        group_id: request.request_id,
      }
    end

    private def set_bugsnag_context(report)
      if account_signed_in?
        report.user = {
          email: current_account.email,
          name: current_account.name,
          username: current_account.username,
          slug: current_account.slug,
          id: current_account.id,
        }
      end

      report.add_tab(:session, {
        actor: PaperTrail.request.whodunnit,
        request_id: request.request_id,
        session_id: if account_signed_in? then session.id end,
      })
    end

    private def serialize(realization)
      JSONAPI::Serializer.serialize(
        if realization.respond_to?(:models) then realization.models else realization.model end,
        is_collection: realization.respond_to?(:models),
        meta: serialized_metadata,
        links: serialized_links,
        jsonapi: serialized_jsonapi,
        fields: if realization.fields.any? then realization.fields end,
        include: if realization.includes.any? then realization.includes end,
        namespace: ::V1
      )
    end

    private def ensure_account_exists
      unless account_signed_in?
        sign_in(Account.create!)
      end
    end

    private def ensure_cart_exists
      cart_loaded_up?
    end

    private def cart_is_unfinished?
      current_cart.present? && current_cart.unfinished?
    end

    private def cart_loaded_up?
      current_cart.present?
    end

    private def current_cart
      @current_cart ||= current_account.unfinished_cart if account_signed_in?
    end

    private def serialized_metadata
      {
        api: {
          version: "1"
        }
      }
    end

    private def serialized_links
      {
        discovery: {
          href: "/"
        }
      }
    end

    private def serialized_jsonapi
      {
        version: "1.0"
      }
    end

    private def upsert_parameter(tree, parameters)
      tree.reduce(parameters) do |accumulated_parameters, (keychain, mapping)|
        mapping.reduce(accumulated_parameters) do |accumulated_mapping, (before, after)|
          if accumulated_mapping.dig(*keychain) == before
            accumulated_mapping.deep_merge(
              keychain.reverse.reduce(after) do |accumulated, key|
                { key => accumulated }
              end
            )
          else
            accumulated_mapping
          end
        end
      end
    end
  end
end
