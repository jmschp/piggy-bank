# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'date'

families = %w[Buscapé Miguel]
goals = ["Bicicleta", "Play Station 5", "PC Gamer", "Livro Mágico", "Cama Elástica", "Canivete Suíço"]

families.each do |family|
  new_fam = Family.create!(name: family)
  User.create!(
    name: "#{family} Buscapé",
    phone: 0,
    email: "#{family}@piggy.com",
    password: "123123",
    admin: true,
    family_id: new_fam.id
  )
end

filhos = []
6.times do
  filho = User.create!(
    name: Faker::Name.first_name,
    email: Faker::Internet.email,
    phone: 0,
    password: "123123",
    admin: false,
    points: rand(50..100),
    family_id: Family.all.sample.id
  )
  filhos << filho
end

40.times do
  Task.create!(
    title: Faker::Lorem.paragraph,
    points: rand(1..5),
    home: [true, false].sample,
    finished: [true, false].sample,
    validated: [true, false].sample,
    user_id: filhos.sample.id
  )
end

40.times do
  Task.create!(
    title: Faker::Lorem.paragraph,
    points: rand(1..5),
    home: [true, false].sample,
    deadline: Date.today + rand(1..10),
    finished: [true, false].sample,
    validated: [true, false].sample,
    user_id: filhos.sample.id
  )
end

filhos.each do |filho|
  points = rand(100..500)
  2.times do
    Goal.create!(
      title: goals.sample,
      points: points,
      total_points: points + 300,
      finished: false,
      user_id: filho.id
    )
  end
  2.times do
    Goal.create!(
      title: goals.sample,
      points: points,
      total_points: points,
      finished: true,
      user_id: filho.id
    )
  end
  4.times do
    Punishment.create!(
      title: Faker::Lorem.paragraph,
      points: rand(1..10),
      date: Date.today - rand(1..10),
      user_id: filho.id
    )
  end
end
