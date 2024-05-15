class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :attendances, dependent: :destroy
  has_many :attendees, through: :attendances, source: :attendee
  validates :name, presence: true
  validate :date_in_future

  scope :past, -> { where('date < ?', Date.today) }
  scope :future, -> { where('date >= ?', Date.today) }

  private

  def date_in_future
    return unless date.present? && date < Date.today

    errors.add(:date, 'Must be in the future')
  end
end
