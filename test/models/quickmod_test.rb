require 'test_helper'

class QuickModTest < ActiveSupport::TestCase
    test "should not allow QuickMods without titles" do
        qm = QuickMod.new
        assert_not qm.save
    end
end
