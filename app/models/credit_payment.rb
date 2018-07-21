class CreditPayment < Payment
  belongs_to(:source)

  def maximum_allowed_cents
    source.amount_cents
  end
end
