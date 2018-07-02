class SubmissionDecorator < ApplicationDecorator
  delegate_all

  decorates_association :subject
  decorates_association :submitter

  def description
    subject.submission_description
  end
end
