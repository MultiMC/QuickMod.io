require 'test_helper'

class VersionsControllerTest < ActionController::TestCase
    fixtures :versions

    setup do
		@version = versions(:test_mod_v1)
		@quickmod = @version.quickmod
	end


    # {{{ Create

    test "should create version" do
		sign_in @quickmod.owner

        assert_difference 'Version.count', 1 do
            post :create, quickmod_id: @quickmod.slug, version: {
                name: '9.0.0.1',
            }
        end
        # No way to check if the path is right, since we don't know what the ID
        # will be.
        assert_response :redirect
    end

    test "should not create version for unowned mod" do
        assert_difference 'Version.count', 0 do
            post :create, quickmod_id: @quickmod.slug, version: {
                name: '9.0.0.1',
            }
        end
        assert_response :forbidden
    end

    # }}}

    # {{{ Show

    test "should show version" do
        get :show, quickmod_id: @quickmod.id, id: @version.id
        assert_response :success
    end

    # }}}

    # {{{ Update

    test "should update version download type" do
        sign_in @quickmod.owner

        new_dl_type = :direct_dl
        patch :update, quickmod_id: @quickmod.id, id: @version.id, version: { id: @version.id, download_type: new_dl_type }

        assert_redirected_to quickmod_version_path(@quickmod, @version)

        vsn = @quickmod.versions.find(@version.id)
        assert_equal new_dl_type.to_s, vsn.download_type
    end

    test "should not update unowned version download type" do
        new_dl_type = :direct_dl
        patch :update, quickmod_id: @quickmod.id, id: @version.id, version: { id: @version.id, download_type: new_dl_type }

        assert_response :forbidden
    end

    # }}}

    # {{{ Delete

    test "should delete version" do
        sign_in @quickmod.owner
        assert_difference 'Version.count', -1 do
            delete :destroy, quickmod_id: @quickmod.id, id: @version.id
        end
        assert_redirected_to quickmod_path(@quickmod)
    end

    test "should not delete unowned version" do
        assert_difference 'Version.count', 0 do
            delete :destroy, quickmod_id: @quickmod.id, id: @version.id
        end
        assert_response :forbidden
    end

    # }}}
end
