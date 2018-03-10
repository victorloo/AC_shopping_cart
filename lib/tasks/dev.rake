namespace :dev do
  task fake: [:fake_product, :fake_users, :fake_orders]

  task fake_products: :environment do
    puts "Start to create fake products"
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

    puts "Start to create fake users"
    15.times do
      response = RestClient.get(url)
      data = JSON.parse(response.body)

      user = User.create!(
        email: data["email"],
        password: "123456",
      )

      puts "created user #{user.email}"
    end

    puts "Start to create fake admins"
    User.create!(
      email: "homer@simpson.com",
      password: "123456",
      role: "admin" #記得管理員的差別是 role
    )
    puts "Default admin Homer created!"

    puts "now you have #{User.count} users data"
  end

  task fake_orders: :environment do
    puts "Start to create fake orders"
    Order.destroy_all
    Cart.destroy_all

    150.times do
      user = User.all.sample
      cart = Cart.create!

      # 將 product 放入 cart
      rand(10).times do
        product = Product.all.sample
        cart.add_cart_item(product)
      end

      # 訂單成立
      order = Order.new(
        sn: (Time.now.to_i + rand(100..999)),
        user_id: user.id,
        amount: cart.subtotal,
        name: user.email.split("@").first,
        phone: FFaker::PhoneNumber.short_phone_number,
        address: FFaker::Address.street_address
      )
      order.add_order_items(cart)
      order.save!
      cart.destroy
    end
    puts "Now you have #{Order.count} order record"
  end

end