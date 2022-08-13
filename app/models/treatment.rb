class Treatment < ApplicationRecord
  belongs_to :client
  default_scope -> { order(date: :desc) }
  validates :client_id, presence: true
  validate :description_and_date

  private

    # Validate presence of description AND date
    def description_and_date
      errors.add(:base, "Oba polja (Datum i Opis) moraju biti ispunjena!") unless
      description.present? && date.present?
    end

end
