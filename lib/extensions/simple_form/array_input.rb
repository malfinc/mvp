class ArrayInput < SimpleForm::Inputs::StringInput
  def input(wrapper_options)
    @fresh_item_text = input_html_options.delete(:fresh_item_text)
    @wrapped_options = merge_wrapper_options(
      input_html_options,
      wrapper_options
    )

    [
      add_new_item,
      current_items,
      if attribute.empty? then template.content_tag(:p, "You have no #{object_name} #{attribute_name}, add some!", id: empty_id) end,
      template.javascript_tag(add_item_script, nonce: template.content_security_policy_script_nonce)
    ].join.html_safe
  end

  def input_type
    :text
  end

  private def current_items
    template.content_tag :ul, id: list_items_id, class: "list-group" do
      attribute.map.with_index do |item, index|
        list_item(item, index)
      end.join.html_safe
    end
  end

  private def add_new_item
    template.content_tag :section, class: "form-actions text-right" do
      @builder.button(
        :button,
        @fresh_item_text,
        id: item_add_id,
        class: "btn-link",
        type: :button
      )
    end
  end

  private def add_item_script
    <<~SCRIPT
      document.getElementById('#{item_add_id}').addEventListener("click", function add_to_#{property} () {
        var position = document.getElementById('#{list_items_id}').children.length
        if (position === 0) {
          document.getElementById('#{empty_id}').parentNode.removeChild(document.getElementById('#{empty_id}'))
        }
        document.getElementById('#{list_items_id}').insertAdjacentHTML('beforeend', '#{list_item("", "INDEX", removal: false).html_safe}'.replace(/INDEX/g, position))
        document.getElementById('#{property}_item_remove_#{property}_' + position).addEventListener("click", function () {
          document.getElementById('#{list_items_id}').removeChild(document.getElementById('#{property}_' + position))
        })
      })
    SCRIPT
  end

  private def remove_item_script(id)
    <<~SCRIPT
      document.getElementById('#{item_remove_id(id)}').addEventListener("click", function () {
        document.getElementById('#{list_items_id}').removeChild(document.getElementById('#{id}'))
      })
    SCRIPT
  end

  private def list_item(item, index, removal: true)
    template.content_tag :li, id: list_item_id(index), class: "list-group-item" do
      template.content_tag :section, class: "input-group" do
        [
          item_field(item, index),
          remove_button(list_item_id(index)),
          if removal then template.javascript_tag(remove_item_script(list_item_id(index)), nonce: template.content_security_policy_script_nonce) end
        ].compact.join.html_safe
      end
    end
  end

  private def item_field(item, index)
    @builder.text_field(
      "#{attribute_name}_#{index}",
      merge_wrapper_options(
        merge_wrapper_options(
          {type: :text}.merge(input_html_options),
          @wrapped_options
        ),
        {value: item, name: "#{object_name}[#{attribute_name}][]"}
      )
    )
  end

  private def remove_button(id)
    template.content_tag :div, class: "input-group-append" do
      @builder.button :button, "Remove", id: item_remove_id(id), class: "btn-outline-secondary", type: :button
    end
  end

  private def attribute
    object.public_send(attribute_name)
  end

  private def list_item_id(index)
    "#{property}_#{index}"
  end

  private def list_items_id
    "#{property}_list_items"
  end

  private def item_add_id
    "#{property}_item_add"
  end

  private def item_remove_id(id)
    "#{property}_item_remove_#{id}"
  end
  private def empty_id
    "#{property}_empty"
  end

  private def property
    "#{object_name}_#{attribute_name}"
  end
end
