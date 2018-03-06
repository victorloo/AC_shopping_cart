namespace :dev do
  task fake_products: :environment do
    Product.destroy_all

    1000.times do |i|
      Product.create!(
        name: FFaker::Product.product_name,
        description: FFaker::Lorem.paragraph,
        price: rand(50..999),
        image: FFaker::Avatar.image # 用FFaker的圖片較快速
      )
    end
    puts "now you have #{Product.count} products data."
  end

  task fake_users: :environment do
    url = "https://uinames.com/api/?ext&region=united%20states"

    15.times do
      response = RestClient.get(url)
      data = JSON.parse(response.body)

      user = User.create!(
        email: data["email"],
        password: "123456",
      )

      puts "created user #{user.email}"
    end

    puts "now you have #{User.count} users data"
  end

end