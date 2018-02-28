namespace :dev do
  task fake_products: :environment do
    1000.times do |i|
      Product.create!(
        name: FFaker::Product.product_name,
        description: FFaker::Lorem.phrase,
        price: rand(50..999),
        image: 
      )
    end
  end
end