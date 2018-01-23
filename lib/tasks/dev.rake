namespace :dev do
  task fake_restaurant: :environment do
    Restaurant.destroy_all

    500.times do |i|
      Restaurant.create!(name: FFaker::Name.first_name,
        opening_hours: FFaker::Time.datetime,
        tel: FFaker::PhoneNumber.short_phone_number,
        address: FFaker::Address.street_address,
        description: FFaker::Lorem.paragraph,
        category: Category.all.sample,
        image: Rails.root.join("public/350x350.png").open
      )
    end
    puts "have created fake restaurants"
    puts "now you have #{Restaurant.count} restaurants data"
  end

  task fake_user: :environment do
    User.destroy_all

    User.create(email: "op880623@gmail.com",
      password: "sdfghj",
      role: "admin",
      name: FFaker::Name.first_name,
      intro: FFaker::Lorem.paragraph,
      avatar: Rails.root.join("public/350x350.png").open
    )
    User.create(email: "test@test.test",
      password: "sdfghj",
      role: nil,
      name: FFaker::Name.first_name,
      intro: FFaker::Lorem.paragraph,
      avatar: Rails.root.join("public/350x350.png").open
    )
    18.times do |i|
      User.create(email: FFaker::InternetSE.email,
        password: "sdfghj",
        role: nil,
        name: FFaker::Name.first_name,
        intro: FFaker::Lorem.paragraph,
        avatar: Rails.root.join("public/350x350.png").open
      )
    end

    puts "An admin account and 19 user accounts have been created."
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

  task fake_favorite: :environment do
    Favorite.destroy_all

    100.times do
      Favorite.create!(restaurant: Restaurant.all.sample, user: User.all.sample)
    end

    Restaurant.all.each do |r|
      r.update_favorites_count
    end
  end

end
