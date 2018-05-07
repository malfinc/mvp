class AddToCartOperation < ApplicationOperation
  task :check_for_missing_product
  task :carbon_copy_cart_item
  task :lock
  task :persist
  task :publish
  error :notify, catch: ProductMissingFromCartItemError
  error :reraise

  schema :check_for_missing_product do
    field :cart_item, type: Types.Instance(CartItem)
  end
  def check_for_missing_product(state:)
    raise ProductMissingFromCartItemError if state.cart_item.product.nil?
  end

  schema :carbon_copy_cart_item do
    field :cart_item, type: Types.Instance(CartItem)
  end
  def carbon_copy_cart_item(state:)
    state.cart_item.carbon_copy
  end

  schema :lock do
    field :cart_item, type: Types.Instance(CartItem)
  end
  def lock(state:)
    GlobalLock.(resource: state.cart_item, type: :row, name: :checking_out, expires_in: 5.minutes)
  end

  schema :persist do
    field :cart_item, type: Types.Instance(CartItem)
  end
  def persist(state:)
    CartItem.transaction do
      state.cart_item.save!
    end

    fresh(current_account: state.cart_item.account, cart_item: state.cart_item)
  end

  schema :publish do
    field :cart_item, type: Types.Instance(CartItem)
    field :current_account, type: Types.Instance(Account)
  end
  def publish(state:)
    CartItemPickedMessage.(subject: state.cart_item, to: state.current_account).via_pubsub.deliver_later!
  end

  def notify(exception:, **)
    Bugsnag.notify(exception)
  end
end
