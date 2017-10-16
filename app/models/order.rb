class MyValidator < ActiveModel::Validator
  def validate(record)
    flag = 0
    qty = record.quantity_array.split(' ').map(&:to_i)
    qty.each do |i|
      if i > 0
        flag = 1
        break
      else
        flag = 0
      end
    end
    if flag == 0
      record.errors[:quantity_array] << "can't be blank"
    end
  end
end


class Order < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user

  validates :item_array, presence: true
  validates :quantity_array, presence: true
  validates :delivery_address, presence: true

  include ActiveModel::Validations
  validates_with MyValidator
end


