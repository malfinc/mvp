class EstablishmentSearchDecorator < ApplicationDecorator
  delegate_all

  decorates_association :results, :with => GooglePlaceResultDecorator
  decorates_association :submitter

  def result_total
    "#{results.count} Google Place result".pluralize(results.count)
  end
end
