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

end
