namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Administrator",
                         email: "admin@ncsu.edu",
                         password: "123456",
                         password_confirmation: "123456")
    admin.toggle!(:admin)

    99.times do |n|
      name = Faker::Name.name
      email = "student-#{n+1}@ncsu.edu"
      password = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    users = User.all(limit: 6)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.microposts.create!(content: content)}
    end
  end
end