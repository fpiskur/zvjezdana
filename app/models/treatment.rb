class Treatment < ApplicationRecord
  belongs_to :client
  validates :client_id, presence: true
  validate :description_and_date

  private

    # Validate presence of description AND date
    def description_and_date
      return if description.present? && date.present?
      errors.add(:base, "Oba polja (Datum i Opis) moraju biti ispunjena!")
    end

end
