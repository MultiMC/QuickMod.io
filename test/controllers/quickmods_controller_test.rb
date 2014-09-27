require 'test_helper'

class QuickModsControllerTest < ActionController::TestCase
    fixtures :quickmods
    fixtures :users

    setup do
        @quickmod = quickmods(:test_mod)
    end

    # {{{ Create

    def create_quickmod_test(succeed)
        assert_difference 'QuickMod.count', succeed ? 1 : 0 do
            post :create, quickmod: {
                uid: 'qmod.create.test',
                name: 'Test Create QuickMod',
            }
        end
    end

    test "should not create QuickMod while signed out" do
        create_quickmod_test(false)
        assert_redirected_to new_user_session_path
    end

    # }}}

    # {{{ Show

    test "should show QuickMod while signed out" do
        get :show, id: @quickmod.to_param
        assert_response :success
    end

    # }}}

    # {{{ Update

    def update_qmod(qmod, fields = {})
        patch :update, id: qmod.to_param, quickmod: fields
    end

    # {{{ Name

    test "should update QuickMod name" do
        new_name = "Name Updated"
        update_qmod @quickmod, name: new_name

        assert_redirected_to quickmod_path(@quickmod.to_param)

        qm = QuickMod.find_by_slug(@quickmod.to_param)
        assert_equal new_name, qm.name
    end

    test "should not update unowned QuickMod" do
        get :show, id: @quickmod.to_param
        assert_response :success
        new_name = "Name Updated"
        update_qmod @quickmod, name: new_name

        assert_response :forbidden
        qm = QuickMod.find_by_slug(@quickmod.to_param)
        assert_not_equal new_name, qm.name
    end

    # }}}

    # }}}

    # {{{ Delete

    test "should delete QuickMod" do
        assert_difference 'QuickMod.count', -1 do
            delete :destroy, id: @quickmod.to_param
        end
        assert_redirected_to quickmods_path
    end

    test "should not delete unowned QuickMod" do
        assert_difference 'QuickMod.count', 0 do
            delete :destroy, id: @quickmod.to_param
            assert_response :forbidden
        end
    end

    # }}}
end
