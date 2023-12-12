# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |index|
  Task.create!(
    name: Faker::Name.unique.name,
    description: Faker::Lorem.sentence,
    status: Faker::Emotion.adjective,
    creator: Faker::ProgrammingLanguage.creator,
    performer: Faker::Artist.name,
    completed: Faker::Boolean.boolean(true_ratio: 0.5)
  )
end
