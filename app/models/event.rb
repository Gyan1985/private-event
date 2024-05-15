class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  validates :name, presence: true
  validate :date_in_future

  private

  def date_in_future
    if date.present? && date < Date.today
      errors.add(:date, 'Must be in the future')
    end
  end
end
