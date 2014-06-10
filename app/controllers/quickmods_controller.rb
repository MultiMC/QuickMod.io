class QuickModsController < ApplicationController
    before_action :set_quickmod, only: [:edit, :update, :show, :destroy]
	before_filter :require_owned, only: [:edit, :update, :destroy]
	before_filter :authenticate_user!, only: [:new, :create]

    def new
        @quickmod = QuickMod.new
    end

    def edit
    end


    def create
        @quickmod = QuickMod.new quickmod_params
		@quickmod.owner = current_user
        @quickmod.save
        respond_to do |format|
            format.json do
                render json: {status: @quickmod.valid?, uid: @quickmod.uid}
            end
            format.html do
                if @quickmod.valid?
                    redirect_to @quickmod
                else
                    render 'new'
                end
            end
        end
    end

    def update
        @quickmod.update quickmod_params
        respond_to do |format|
            format.json do
                render json: {status: @quickmod.valid?, uid: @quickmod.uid}
            end
            format.html do
                if @quickmod.valid?
                    redirect_to @quickmod
                else
                    render 'edit'
                end
            end
        end
    end


    def show
    end

    def index
        @quickmods = QuickMod.all
    end


    def destroy
        @quickmod.destroy
        redirect_to quickmods_path
    end


    def ajax_validate
        if request.patch?
            @quickmod = QuickMod.friendly.find(params[:quickmod][:original_uid])
            @quickmod.attributes = quickmod_params
        else
            @quickmod = QuickMod.new quickmod_params
        end
        respond_to do |format|
            format.json do
                render json: {status:  @quickmod.valid?, errors: @quickmod.errors.messages}
            end
        end
    end

    private
    def set_quickmod
        @quickmod = QuickMod.friendly.find(params[:id])
    end

	def require_owned
		if not @quickmod.owned_by?(current_user)
			render 'denied', status: :forbidden
		end
	end

    def quickmod_params
        params.require(:quickmod).permit(:uid, :name, :description, :tags, :categories)
    end

end

