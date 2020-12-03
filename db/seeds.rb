# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'date'

families = %w[Pimenta Hargreaves Buscapé]
goals = ["Bicicleta", "Play Station 5", "PC Gamer", "Livro Mágico", "Cama Elástica", "Canivete Suíço"]
task_type = ["Casa", "Escola"]

families.each do |family|
  new_fam = Family.create!(name: family)
  User.create!(
    name: "Leader #{family}",
    email: "#{family}@piggy.com",
    password: 123123,
    admin: true,
    family_id: new_fam.id
  )
end

filhos = []
6.times do
  filho = User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: 123123,
    admin: false,
    points: rand(50..100),
    family_id: Family.all.sample.id
  )
  filhos << filho
end

20.times do
  Task.create!(
    title: Faker::Lorem.paragraph,
    points: rand(1..5),
    task_type: task_type.sample,
    finished: [true, false].sample,
    user_id: filhos.sample.id
  )
end

20.times do
  Task.create!(
    title: Faker::Lorem.paragraph,
    points: rand(1..5),
    task_type: task_type.sample,
    deadline: Date.today + rand(1..10),
    finished: [true, false].sample,
    user_id: filhos.sample.id
  )
end

filhos.each do |filho|
  Goal.create!(
    title: goals.sample,
    points: rand(100..500),
    finished: true,
    user_id: filho.id
  )
  Goal.create!(
    title: goals.sample,
    points: rand(100..500),
    finished: false,
    user_id: filho.id
  )
end
