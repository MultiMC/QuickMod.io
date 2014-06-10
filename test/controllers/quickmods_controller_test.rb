require 'test_helper'

class QuickModsControllerTest < ActionController::TestCase
    fixtures :quickmods
    fixtures :users

    setup do
		@quickmod = quickmods(:test_mod)
    end

    test "should not create QuickMod while signed out" do
        assert_difference 'QuickMod.count', 0 do
            post :create, quickmod: {
                uid: 'qmod.create.test',
                name: 'Test Create QuickMod',
            }
            assert_redirected_to new_user_session_path
        end
    end

    test "should create QuickMod while signed in" do
		sign_in @quickmod.owner

        assert_difference 'QuickMod.count', 1 do
            post :create, quickmod: {
                uid: 'qmod.create.test',
                name: 'Test Create QuickMod',
            }
            assert_redirected_to quickmod_path('qmod-create-test')
        end
    end


    test "should show QuickMod while signed in" do
		sign_in @quickmod.owner

        get :show, id: @quickmod.slug
        assert_response :success
    end

    test "should show QuickMod while signed out" do
        get :show, id: @quickmod.slug
        assert_response :success
    end


    test "should update QuickMod name" do
		sign_in @quickmod.owner

        new_name = "Name Updated"
        patch :update, id: @quickmod.slug, quickmod: { name: new_name }

        assert_redirected_to quickmod_path(@quickmod.slug)

        qm = QuickMod.friendly.find(@quickmod.slug)
        assert_equal new_name, qm.name
    end

	test "should not update unowned QuickMod" do
        get :show, id: @quickmod.slug
        assert_response :success
        new_name = "Name Updated"
        patch :update, id: @quickmod.slug, quickmod: { name: new_name }

		assert_response :forbidden
	end


    test "should delete QuickMod" do
		sign_in @quickmod.owner

        assert_difference 'QuickMod.count', -1 do
            delete :destroy, id: @quickmod.slug
        end
        assert_redirected_to quickmods_path
    end

	test "should not delete unowned QuickMod" do
        assert_difference 'QuickMod.count', 0 do
            delete :destroy, id: @quickmod.slug
            assert_response :forbidden
        end
	end
end
