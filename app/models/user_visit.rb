class UserVisit < ActiveRecord::Base
  belongs_to :user, :inverse_of => :visits
  belongs_to :country, :foreign_key => :country_code, :primary_key => :code, :inverse_of => :user_visits
end