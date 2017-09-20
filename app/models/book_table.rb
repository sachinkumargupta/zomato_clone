class BookTable < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant

  validates :date, presence: true
  validates :headcount, presence: true
  validates :duration, presence: true, inclusion: { in: ["30 min", "1 hour", "1:30 hour", "2 hours"]}
  validates_numericality_of :headcount, greater_than_or_equal_to: 1, only_integer: true, if: Proc.new{ |a| a.headcount.present? }
  validate :must_have_valid_future_datetime?

  private
    def must_have_valid_future_datetime?
      if date.present?
        valid_datetime 
        future_datetime
      end
    end

    def valid_datetime
      errors.add(:date, "must be a valid date") unless date.to_datetime.is_a?(DateTime)
    end

    def future_datetime
      errors.add(:date, "can't be in the past") if date.to_datetime < DateTime.now
      errors.add(:date, "- table booking is possible only till 2 months from today's date") if date.to_datetime > (DateTime.now + 2.months)
    end
end