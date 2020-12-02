# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

families = %w[Pimenta Hargreaves Buscapé]
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
10.times do
  filho = User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: 123123,
    admin: false,
    family_id: Family.all.sample.id
  )
  filhos << filho
end


50.times do
  Task.create!(
    title: Faker::Lorem.paragraph,
    description: Faker::Lorem.paragraph(sentence_count: 2),
    points: rand(1..5),
    task_type: task_type.sample,
    user_id: filhos.sample.id
  )
end
