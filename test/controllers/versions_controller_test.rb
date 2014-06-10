require 'test_helper'

class VersionsControllerTest < ActionController::TestCase
    fixtures :versions

    setup do
		@version = versions(:test_mod_v1)
		@quickmod = @version.quickmod
	end

    test "should show version" do
        get :show, quickmod_id: @quickmod.id, id: @version.id
        assert_response :success
    end

    test "should update version download type" do
        new_dl_type = :direct_dl
        patch :update, quickmod_id: @quickmod.id, id: @version.id, version: { id: @version.id, download_type: new_dl_type }

        assert_redirected_to quickmod_version_path(@quickmod, @version)

        vsn = @quickmod.versions.find(@version.id)
        assert_equal new_dl_type.to_s, vsn.download_type
    end

    test "should delete version" do
        assert_difference 'Version.count', -1 do
            delete :destroy, quickmod_id: @quickmod.id, id: @version.id
        end
        assert_redirected_to quickmod_path(@quickmod)
    end
end
