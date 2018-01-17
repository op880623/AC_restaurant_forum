namespace :dev do
  task fake_restaurant: :environment do
    Restaurant.destroy_all

    500.times do |i|
      Restaurant.create!(name: FFaker::Name.first_name,
        opening_hours: FFaker::Time.datetime,
        tel: FFaker::PhoneNumber.short_phone_number,
        address: FFaker::Address.street_address,
        description: FFaker::Lorem.paragraph,
        category: Category.all.sample
      )
    end
    puts "have created fake restaurants"
    puts "now you have #{Restaurant.count} restaurants data"
  end

  task fake_user: :environment do
    User.destroy_all

    User.create(email: "op880623@gmail.com", password: "sdfghj", role: "admin")
    20.times do |i|
      User.create(email: FFaker::InternetSE.email, password: "sdfghj", role: nil)
    end

    puts "An admin account and 20 user accounts have been created."
  end

  task fake_comment: :environment do
    Comment.destroy_all

    Restaurant.all.each do |r|
      3.times do
        r.comments.create(content: FFaker::Lorem.sentence, user: User.all.sample)
      end
    end

    puts "Add 3 comments to each restaurant."
  end
end
