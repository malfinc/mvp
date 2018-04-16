class Submission < ApplicationComputed
  attr_accessor :subject

  def self.all
    [
      *Recipe.with_moderation_state(:draft),
      *Establishment.with_moderation_state(:draft),
      *MenuItem.with_moderation_state(:draft)
    ].compact.map do |subject|
      new(id: "#{subject.class.name}-#{subject.id}", subject: subject)
    end
  end

  def name
    subject.name
  end

  def submitter
    case subject
    when Recipe then subject.author
    end
  end

  def category
    subject.class.model_name
  end

  def description
    case subject
    when Recipe then subject.description
    end
  end

  def subject_type
    subject.class.name
  end

  def updated_at
    subject.updated_at
  end
end
