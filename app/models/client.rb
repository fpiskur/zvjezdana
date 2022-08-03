class Client < ApplicationRecord

  has_many :treatments, dependent: :destroy

  # validates :first_name, presence: true, unless: ->(client) { client.last_name.present? }
  # validates :last_name, presence: true, unless: ->(client) { client.first_name.present? }

  validate :first_name_or_last_name

  private

    # Validate presence of first_name OR last_name
    def first_name_or_last_name
      errors.add(:base, "Ispunite barem jedno od polja - Ime ili Prezime.") unless
      first_name.present? || last_name.present?
    end
end
