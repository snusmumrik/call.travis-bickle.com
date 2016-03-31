class OrdersTaxi < ActiveRecord::Base
  belongs_to :order
  belongs_to :taxi
end
