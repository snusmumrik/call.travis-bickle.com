# -*- coding: utf-8 -*-

class Order < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :taxis, dependent: :destroy
  has_and_belongs_to_many :person_in_charges, dependent: :destroy

  acts_as_paranoid

  validates :latitude, :longitude, presence: true

  geocoded_by :address
  after_validation :geocode, if: lambda {|obj| obj.address_changed?}

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode, if: lambda {|obj| obj.latitude_changed? && obj.longitude_changed?}

  before_save do
    self.address.sub!(/日本, 〒[0-9-]+ /, "")
    self.location = Location.near(self.address).first.try(:name)
  end
end
