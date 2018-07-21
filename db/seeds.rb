# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

PaperTrail.controller_info = {
  :context_id => SecureRandom.uuid
}
PaperTrail.request(:whodunnit => "The Seed") do
  ActiveRecord::Base.transaction do
    if Rails.env.production? && Account.count.zero?
      krainboltgreene = Account.create!(
        :username => "krainboltgreene",
        :name => "Kurtis Rainbolt-Greene",
        :email => "kurtis@rainbolt-greene.online",
        :password => SecureRandom.hex(32)
      )
      krainboltgreene.convert!
      krainboltgreene.complete!
      krainboltgreene.spark!
    end

    if Rails.env.development?
      administrator = Account.create!(
        :username => "sally",
        :name => "Sally Stuthers",
        :email => "sally@example.com",
        :password => "password"
      )
      administrator.convert!
      administrator.complete!
      administrator.spark!

      operator = Account.create!(
        :username => "mark",
        :name => "Mark Muffalo",
        :email => "mark@example.com",
        :password => "password"
      )
      operator.convert!
      operator.complete!
      operator.empower!

      buyer = Account.create!(
        :username => "calvin",
        :name => "Calvin Klean",
        :email => "calvin@example.com",
        :password => "password"
      )
      buyer.convert!
      buyer.complete!
    end
  end
end
