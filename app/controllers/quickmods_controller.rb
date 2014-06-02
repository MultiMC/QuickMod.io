class QuickModsController < ApplicationController

    before_action :set_quickmod, only: [:edit, :update, :show, :ajax_edit, :ajax_show]

    def new
        @quickmod = QuickMod.new
    end

    def edit
    end


    def create
        @quickmod = QuickMod.new quickmod_params
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
        @quickmod.update quickmod_params(true)
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

    def ajax_validate
        if request.patch?
            @quickmod = QuickMod.friendly.find(params[:quickmod][:original_uid])
            @quickmod.attributes = quickmod_params quickmod_params(true)
        else
            @quickmod = QuickMod.new
        end
        respond_to do |format|
            format.json do
                render json: {status:  @quickmod.valid?, errors: @quickmod.errors.messages}
            end
        end
    end

    def ajax_new
        @type = :new
        @quickmod = QuickMod.new
        render 'quickmods/modals/form', layout: false
    end

    def ajax_edit
        @type = :edit
        render 'quickmods/modals/form', layout: false
    end

    def ajax_show
        render 'quickmods/modals/show', layout: false
    end

    private

    def set_quickmod
        @quickmod = QuickMod.friendly.find(params[:id])
    end

    def quickmod_params(edit = false)
        params.require(:quickmod).permit(:uid, :name, :description, :tags, :categories)
    end

end

