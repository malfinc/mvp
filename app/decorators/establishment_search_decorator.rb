class EstablishmentSearchDecorator < ApplicationDecorator
  delegate_all

  decorates_association(:results, :with => GooglePlaceResultDecorator)
  decorates_association(:submitter)

  def result_total
    "#{results.count} result".pluralize(results.count)
  end
end
