class Client < ApplicationRecord
  has_many :treatments, dependent: :destroy
end
