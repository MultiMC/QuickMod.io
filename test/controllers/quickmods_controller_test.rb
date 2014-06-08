require 'test_helper'

class QuickModsControllerTest < ActionController::TestCase
    fixtures :quickmods

    setup do
		@quickmod = quickmods(:basic_test_one)
    end

    test "should show QuickMod" do
        get :show, id: @quickmod.slug
        assert_response :success
    end

    test "should update QuickMod name" do
        new_name = "Name Updated"
        patch :update, id: @quickmod.slug, quickmod: { name: new_name }

        assert_redirected_to quickmod_path(@quickmod.slug)

        qm = QuickMod.friendly.find(@quickmod.slug)
        assert_equal new_name, qm.name
    end

    test "should delete QuickMod" do
        assert_difference 'QuickMod.count', -1 do
            delete :destroy, id: @quickmod.slug
        end
        assert_redirected_to quickmods_path
    end
end
