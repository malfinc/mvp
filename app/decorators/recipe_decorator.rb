class RecipeDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def description
    Redcarpet::Render::SmartyPants.render(
      Redcarpet::Markdown.new(
        Redcarpet::Render::HTML.new(
          no_links: true,
          no_styles: true,
          no_images: true,
          hard_warp: true,
        )
      ).render(
        object.description
      )
    ).html_safe
  end

  def summary
    object.description.truncate(69)
  end
end
