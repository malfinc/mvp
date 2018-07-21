class CartItemAddedRealtimeMessage < RealtimeMessage
  CHANNEL = "cart-items".freeze

  attr_accessor(:cart_item)

  def call
    client.publish(
      :channel => channel,
      :message => {
        :cart_item => message.fetch(:cart_item).to_gid
      }
    )
  end
end
