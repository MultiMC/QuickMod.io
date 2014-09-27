class VersionsController < ApplicationController
    before_action :set_quickmod
    before_action :set_version, only: [:edit, :update, :show, :destroy]
    before_filter :require_owned, only: [:new, :create, :edit, :update, :destroy]

    def new
        @version = @quickmod.versions.new
    end

    def edit
    end

    
    def create
        @version = @quickmod.versions.new version_params
        @version.save
        respond_to do |format|
            format.json do
                render json: {status: @quickmod.valid?, uid: @quickmod.uid}
            end
            format.html do
                if @version.valid?
                    redirect_to [@quickmod, @version]
                else
                    render 'new'
                end
            end
        end
    end

    def update
        @version.update version_params
        respond_to do |format|
            format.json do
                respond_with_bip @version
            end
            format.html do
                if @version.valid?
                    redirect_to [@quickmod, @version]
                else
                    render 'edit'
                end
            end
        end
    end


    def show
    end


    def destroy
        @version.destroy
        redirect_to @quickmod
    end


    def ajax_validate
        if request.patch?
            @version = @quickmod.versions.find(params[:id])
            @version.attributes = version_params
        else
            @version = @quickmod.versions.new version_params
        end
        respond_to do |format|
            format.json do
                render json: {status: @version.valid?,
                              errors: @version.errors.messages}
            end
        end
    end

    private
	def require_owned
	end

    def set_quickmod
        @quickmod = QuickMod.find(params[:quickmod_id])
    end

    def set_version
        @version = @quickmod.versions.find(params[:id])
    end

    def version_params
        params.require(:version).permit(:name, :version_type, :download_type, :install_type, :md5, :url)
    end
end
