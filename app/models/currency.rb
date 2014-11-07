class Currency < ActiveRecord::Base
  self.primary_key = :code
  attr_accessible :name, :code, :country_id

  validates_presence_of :name
  validates_presence_of :code
  validates_uniqueness_of :code, :allow_blank => true


  belongs_to :country

  def self.with_collection_data_for(user)
    joins(:country).merge(Country.with_visits_data_for(user)).except(:select).select("currencies.*, user_visits.id IS NOT NULL as collected")
  end

  def self.collected_by(user)
    with_collection_data_for(user).where("user_visits.id IS NOT NULL")
  end

  def self.not_collected_by(user)
    with_collection_data_for(user).where("user_visits.id IS NULL")
  end

  def collected_by?(user)
    !self.class.with_collection_data_for(user).find(code).collected.zero?
  end
end
