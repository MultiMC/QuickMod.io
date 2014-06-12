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

    test "should create QuickMod while signed in" do
        sign_in @quickmod.owner
        create_quickmod_test(true)
        assert_redirected_to quickmod_path('qmod-create-test')
    end

    # }}}

    # {{{ Show

    test "should show QuickMod while signed in" do
        sign_in @quickmod.owner

        get :show, id: @quickmod.slug
        assert_response :success
    end

    test "should show QuickMod while signed out" do
        get :show, id: @quickmod.slug
        assert_response :success
    end

    # }}}

    # {{{ Update

    def update_qmod(qmod, fields = {})
        patch :update, id: qmod.slug, quickmod: fields
    end

    # {{{ Name

    test "should update QuickMod name" do
        sign_in @quickmod.owner

        new_name = "Name Updated"
        update_qmod @quickmod, name: new_name

        assert_redirected_to quickmod_path(@quickmod.slug)

        qm = QuickMod.friendly.find(@quickmod.slug)
        assert_equal new_name, qm.name
    end

    test "should not update unowned QuickMod" do
        get :show, id: @quickmod.slug
        assert_response :success
        new_name = "Name Updated"
        update_qmod @quickmod, name: new_name

        assert_response :forbidden
        qm = QuickMod.friendly.find(@quickmod.slug)
        assert_not_equal new_name, qm.name
    end

    # }}}

    # {{{ Tags & Categories

    test "should update QuickMod tags and categories" do
        sign_in @quickmod.owner

        new_tags = ['test', 'lol', 'hello']
        new_cats = ['categories', 'lol', 'hi']
        update_qmod @quickmod, tags_tokens: new_tags.join(', '),
                               categories_tokens: new_cats.join(', ')

        assert_redirected_to quickmod_path(@quickmod.slug)
        qm = QuickMod.friendly.find(@quickmod.slug)
        assert_equal new_tags, qm.tags
        assert_equal new_cats, qm.categories
    end

    # }}}

    # }}}

    # {{{ Delete

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

    # }}}
end
