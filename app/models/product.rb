class Product < ApplicationRecord
  validate_presence_of(:name, :description, :price)

end