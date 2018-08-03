FactoryBot.define do
  factory :cart do
    trait :without_billing_information do
      checkout_state :needs_billing_information
    end
    trait :without_billing_information do
      checkout_state :needs_billing_information
    end
  end
end
