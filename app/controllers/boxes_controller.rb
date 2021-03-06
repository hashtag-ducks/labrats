class BoxesController < ApplicationController
    include NotebookAccessHelper

    before_filter :signed_in_user
    before_filter :allowed_access

    respond_to :json

    def show
        @box = Box.find(params[:id])
        respond_with @box
    end

    def update
        @box = Box.find(params[:id])
        @filtered_params = params[:box].select do |k, v|
            @box.class.accessible_attributes.include? k
        end
        if @box.update_attributes(@filtered_params)
            respond_with @box
        else
            render :nothing => true, status: :unprocessable_entity
        end
    end

    def upload_file
        @box = Box.find(params[:id])
        @box.file = params[:file].read
        @box.save
        respond_to do |format|
            format.json { head :ok }
        end
    end

    def model_class
        Box
    end
end
