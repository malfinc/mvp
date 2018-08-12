class Search < ApplicationComputed
  include(RedisBacked)

  redis_value(:query, :expiration => 1.day)
  redis_value(:results, :expiration => 1.day)

  validates_presence_of(:query)

  def results=(value)
    super(value.map(&RESULT_CLASS.method(:serialize)).to_json)
  end

  def results
    Oj.load(super).map {|raw| RESULT_CLASS.new(**raw.symbolize_keys)} if super.present?
  end

  def result_total
    "#{results.count} result".pluralize(results.count)
  end

  def persisted?
    query.present?
  end

  def subtype
    self.class.name.gsub("Search", "").tableize
  end
end
