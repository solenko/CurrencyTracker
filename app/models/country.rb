class Country < ActiveRecord::Base
  self.primary_key = :code
  attr_accessible :name, :code

  validates_presence_of :name
  validates_presence_of :code
  validates_uniqueness_of :code, :allow_blank => true

  has_many :currencies
  has_many :user_visits, :foreign_key => :country_code, :dependent => :delete_all do
    def for(user)
      where(:user_id => user.id)
    end
  end

  accepts_nested_attributes_for :currencies, :allow_destroy => true

  scope :with_visits_data_for, ->(user) {
    return where("1 = 0") unless user
    joins(sprintf("LEFT JOIN user_visits ON user_visits.country_code = countries.code AND user_visits.user_id = %d", user.id)).
    select("countries.*, user_visits.id IS NOT NULL as visited")
  }
  scope :visited_by, ->(user) { with_visits_data_for(user).where("user_visits.id IS NOT NULL") }
  scope :not_visited_by, ->(user) { with_visits_data_for(user).where({:user_visits => {:id => nil}}) }

  def visited_by?(user)
    # if instance respond to :visited, than we already load visits info with with_visits_data_for and no additional query needed
    if respond_to? :visited
      !visited.zero?
    else
      user_visits.for(user).any?
    end
  end

end
