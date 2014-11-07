class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable

  attr_accessible :email, :password, :password_confirmation

  has_many :visits, :class_name => 'UserVisit', :foreign_key => :user_id, :dependent => :delete_all

  def mark_visited!(country)
    visits.where(:country_code => country.code).first_or_create!
  end

  def mark_not_visited!(country)
    visits.where(:country_code => country.code).destroy_all
  end

  def bulk_mark_visited!(countries)
    hashes = []
    countries.each do |country|
      hashes << {:country => country}
      country[:visited] = 1
    end
    visits.create!(hashes)

  end

  def visited_countries
    Country.visited_by(self)
  end

  def not_visited_countries
    Country.not_visited_by(self)
  end

end
