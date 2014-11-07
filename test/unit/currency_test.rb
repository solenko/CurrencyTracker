require 'test_helper'

class CurrencyTest < ActiveSupport::TestCase
  test_validates_presence_of :name, :code

  test "has valid factory" do
    assert FactoryGirl.build(:currency).valid?
  end
end
