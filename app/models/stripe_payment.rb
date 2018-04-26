class StripePayment < Payment
  def maximum_allowed_cents
    Float::Infinite
  end

  def source
    nil
  end
end
