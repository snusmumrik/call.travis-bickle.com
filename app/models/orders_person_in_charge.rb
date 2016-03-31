class OrdersPersonInCharge < ActiveRecord::Base
  belongs_to :order
  belongs_to :person_in_charge
end
