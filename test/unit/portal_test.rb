require 'test_helper'

class PortalTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Portal.new.valid?
  end
end
