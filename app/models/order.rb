# -*- coding: utf-8 -*-

class Order < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :taxis
  has_and_belongs_to_many :person_in_charges

  acts_as_paranoid

  validates :latitude, :longitude, presence: true

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  before_save do
    self.address.sub!(/日本, 〒[0-9-]+ /, "")
  end
end
