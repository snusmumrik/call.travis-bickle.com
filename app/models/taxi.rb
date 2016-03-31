class Taxi < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :orders

  acts_as_paranoid
end
