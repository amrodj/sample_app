namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Administrator",
                 email: "admin@ncsu.edu",
                 password: "123456",
                 password_confirmation: "foobar",
                 admin: true)
    10.times do |n|
      name  = Faker::Name.name
      email = "student-#{n+1}@ncsu.edu"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password,
                   admin: false)
    end

    users = User.all(limit: 8)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.microposts.create!(content: content) }
    end
  end
end