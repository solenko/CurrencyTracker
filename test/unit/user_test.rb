require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "has valid factory" do
    assert FactoryGirl.build(:user).valid?
  end
end
