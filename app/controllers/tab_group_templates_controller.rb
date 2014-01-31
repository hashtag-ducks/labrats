class TabGroupTemplatesController < ApplicationController
    include NotebookAccessHelper

    before_filter :signed_in_user
    before_filter :notebook_owner, only: :destroy

    respond_to :json

    def create
        @tab_group_template = TabGroupTemplate.create(params[:tab_group_template])
        check_user(@tab_group_template) && return
        if @tab_group_template.save
            respond_with @tab_group_template
        else
            render :nothing => true, status: :unprocessable_entity
        end
    end

    def destroy
        TabGroupTemplate.find(params[:id]).destroy
        respond_to do |format|
            format.json { head :ok }
        end
    end

    def model_class
        TabGroupTemplate
    end
end
