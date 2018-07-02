class Submission < ApplicationComputed
  attr_accessor :subject

  def self.all
    [
      *Recipe.with_moderation_state(:draft),
      *Establishment.with_moderation_state(:draft),
      *MenuItem.with_moderation_state(:draft)
    ].compact.map do |subject|
      new(:id => "#{subject.class.name}-#{subject.id}", :subject => subject)
    end
  end

  delegate :name, :to => :subject

  def category
    subject.class.model_name
  end

  def subject_type
    subject.class.name
  end

  def submitter
    case subject
    when Recipe then subject.author
    when Establishment then subject.contributors.first
    when MenuItem then subject.contributors.first
    end
  end
end
