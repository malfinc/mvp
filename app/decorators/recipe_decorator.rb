class RecipeDecorator < ApplicationDecorator
  delegate_all

  def rendered_description
    Redcarpet::Render::SmartyPants.render(
      Redcarpet::Markdown.new(
        Redcarpet::Render::HTML.new(
          :no_links => true,
          :no_styles => true,
          :no_images => true,
          :hard_warp => true
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
