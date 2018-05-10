class StripePayment < Payment
  def maximum_allowed_cents
    Float::INFINITY
  end

  def source
    false
  end
end
