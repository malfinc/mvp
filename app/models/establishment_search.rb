class EstablishmentSearch < ApplicationComputed
  include RedisBacked

  redis_value :query, :expiration => 1.day
  redis_value :results, :expiration => 1.day

  validates_presence_of :query

  def results=(value)
    super(value.map(&GooglePlaceResult.method(:serialize)).to_json)
  end

  def results
    Oj.load(super).map {|raw| GooglePlaceResult.new(**raw.symbolize_keys)} if super.present?
  end

  def persisted?
    query.present?
  end
end
