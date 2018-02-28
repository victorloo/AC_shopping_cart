class Product < ApplicationRecord
  validate_presence_of(:name, :description, :price)

  mount_uploader :image, PhotoUploader
end