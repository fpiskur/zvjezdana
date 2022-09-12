class Treatment < ApplicationRecord

  belongs_to :client
  validates :client_id, :description, :date, presence: true
  
end
