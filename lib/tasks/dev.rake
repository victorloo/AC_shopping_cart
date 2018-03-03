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

end