class Order < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :taxis
  has_and_belongs_to_many :person_in_charges

  acts_as_paranoid
end
