require 'test_helper'

class QuickModFlowsTest < ActionDispatch::IntegrationTest
    fixtures :quickmods

    test "create and delete QuickMod" do
        get "/quickmods/new"
        assert_response :success

        created_mod_path = "/quickmods/test-create-quickmod"

        post_via_redirect "/quickmods", quickmod: {
            uid: "test.create.quickmod",
            name: "QuickMod Creation Test",
            description: "This is a test description."
        }

        # We should have been redirected to the QuickMod's page.
        assert_equal created_mod_path, path

        # Now try deleting it.
        delete created_mod_path

        # We should be redirected to the QuickMods index.
        assert_redirected_to "/quickmods"

        # Ensure the QuickMod was deleted.
        assert_raises(ActiveRecord::RecordNotFound) { get created_mod_path }
    end
end

