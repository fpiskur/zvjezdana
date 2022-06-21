class Treatment < ApplicationRecord
  belongs_to :client
  default_scope -> { order(date: :desc) }
  validates :client_id, presence: true
end
