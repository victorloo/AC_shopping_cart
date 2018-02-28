namespace :dev do
  task fake_products: :environment do

    url = "https://uinames.com/api/?ext&region=england"

    1000.times do |i|
      response = RestClient.get(url)
      data = JSON.parse(response.body)

      Product.create!(
        name: FFaker::Product.product_name,
        description: FFaker::Lorem.phrase,
        price: rand(50..999),
        image: data["photo"]
      )
    end
    puts "now you have #{Product.count} products data."
  end
end