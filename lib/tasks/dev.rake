namespace :dev do
  task fake_products: :environment do
    Product.destroy_all

    1000.times do |i|
      Product.create!(
        name: FFaker::Product.product_name,
        description: FFaker::Lorem.phrase,
        price: rand(50..999),
        image: File.open(File.join(Rails.root, "/seed_img/#{rand(0..20)}.jpg"))
      )
    end
    puts "now you have #{Product.count} products data."
  end
end