class Client < ApplicationRecord

  has_many :treatments, dependent: :destroy
  validate :first_name_or_last_name

  private

    # Validate presence of first_name OR last_name
    def first_name_or_last_name
      return if first_name.present? || last_name.present?
      errors.add(:base, "Ispunite barem jedno od polja - Ime ili Prezime.")
    end
    
end
