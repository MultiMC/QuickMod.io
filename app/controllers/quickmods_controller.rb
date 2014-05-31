class QuickModsController < ApplicationController
    def new
        @quickmod = QuickMod.new
    end

    def edit
        @quickmod = QuickMod.friendly.find(params[:id])
    end


    def create
        @quickmod = QuickMod.new quickmod_params

        if @quickmod.save
            redirect_to @quickmod
        else
            render "new"
        end
    end

    def update
        @quickmod = QuickMod.friendly.find(params[:id])

        respond_to do |format|
            if @quickmod.update quickmod_params
                format.html { redirect_to @quickmod }
                format.json { respond_with_bip @quickmod }
            else
                format.html { render "edit" }
                format.json { respond_with_bip @quickmod }
            end
        end
    end


    def show
        @quickmod = QuickMod.friendly.find(params[:id])
    end

    def index
        @quickmods = QuickMod.all
    end


    private

    def quickmod_params
        params.require(:quickmod).permit(:uid, :name, :description, :tags, :categories)
    end
end

