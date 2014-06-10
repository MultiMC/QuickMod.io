require 'test_helper'

class QuickModTest < ActiveSupport::TestCase
    fixtures(:quickmods)
    fixtures(:users)

    test "should not allow QuickMods without titles" do
        qm = QuickMod.new
        assert_not qm.save
    end

    test "owner should be determined properly" do
        qm = quickmods(:test_mod)

        assert     qm.owned_by?(users(:user_one))
        assert_not qm.owned_by?(users(:mike_hawk))
    end
end
