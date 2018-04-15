class SubmissionDecorator < ApplicationDecorator
  delegate_all

  decorates_association :subject
end
