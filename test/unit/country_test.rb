require 'test_helper'

class CountryTest < ActiveSupport::TestCase
  setup do
    @current_user = nil
    @another_user = nil
    @visited_country = nil
    @not_visited_country = nil
  end

  test_validates_presence_of :name, :code

  test "has valid factory" do
    assert FactoryGirl.build(:country).valid?
  end

  test "#with_visits_data_for return full country list" do
    setup_visits_data
    assert_equal 2, Country.with_visits_data_for(current_user).count
    assert_include Country.with_visits_data_for(current_user), visited_country
    assert_include Country.with_visits_data_for(current_user), not_visited_country
  end

  test "#visited_by? use correct user data" do
    setup_visits_data
    assert visited_country.visited_by?(current_user)
    assert_equal false, not_visited_country.visited_by?(current_user)

  end

  def setup_visits_data
    FactoryGirl.create :user_visit, :country => visited_country, :user => current_user
    FactoryGirl.create :user_visit, :country => visited_country, :user => another_user
    FactoryGirl.create :user_visit, :country => not_visited_country, :user => another_user
  end

  def current_user
    @current_user ||= FactoryGirl.create :user
  end

  def another_user
    @another_user ||= FactoryGirl.create :user
  end

  def visited_country
    @visited_country ||= FactoryGirl.create :country
  end

  def not_visited_country
    @not_visited_country ||= FactoryGirl.create :country
  end

end