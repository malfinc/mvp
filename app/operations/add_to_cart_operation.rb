class AddToCartOperation < ApplicationOperation
  task(:check_for_missing_product)
  task(:carbon_copy_cart_item)
  task(:lock)
  task(:persist)
  task(:publish)
  catch(:notify, :exception => ProductMissingFromCartItemError)
  catch(:reraise)

  schema(:check_for_missing_product) do
    field(:cart_item, :type => Types.Instance(CartItem))
  end
  def check_for_missing_product(state:)
    raise(ProductMissingFromCartItemError) if state.cart_item.product.nil?
  end

  schema(:carbon_copy_cart_item) do
    field(:cart_item, :type => Types.Instance(CartItem))
  end
  def carbon_copy_cart_item(state:)
    state.cart_item.carbon_copy
  end

  schema(:lock) do
    field(:cart_item, :type => Types.Instance(CartItem))
  end
  def lock(state:)
    database_lock!(:resource => state.cart_item)
  end

  schema(:persist) do
    field(:cart_item, :type => Types.Instance(CartItem))
  end
  def persist(state:)
    CartItem.transaction do
      state.cart_item.save!
    end

    fresh(:state => {:current_account => state.cart_item.account, :cart_item => state.cart_item})
  end

  schema(:publish) do
    field(:cart_item, :type => Types.Instance(CartItem))
    field(:current_account, :type => Types.Instance(Account))
  end
  def publish(state:)
    CartItemAddedRealtimeMessage.(
      :to => state.current_account,
      :message => {
        :cart_item => state.cart_item
      }
    )
  end

  def notify(exception:, **)
    Bugsnag.notify(exception)
  end
end
