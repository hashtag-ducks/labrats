class PageTemplatesController < ApplicationController
    include NotebookAccessHelper

    before_filter :signed_in_user
    before_filter :notebook_owner, only: :destroy

    respond_to :json

    def create
        @page_template = PageTemplate.new(params[:page_template])
        check_user(@page_template) && return
        if @page_template.save
            respond_with @page_template
        else
            respond_with @page_template, status: :unprocessable_entity
        end
    end

    def destroy
        PageTemplate.find(params[:id]).destroy
        respond_to do |format|
            format.json { head :ok }
        end
    end

    def update
      page_template = PageTemplate.find(params[:id])
      check_user(page_template) && return
      # This sucks and should be more general but Rails is being a
      # pain in the ass and for some reason we're using Rails 3
      # instead of Rails 4 where we can just say
      # `params.permit(:name)`. Fuck it.
      page_template.name = params[:page_template][:name]
      page_template.ordering = params[:page_template][:ordering]
      if page_template.save
        respond_with page_template
      else
        respond_with page_template, status: :unprocessable_entity
      end
    end

    def model_class
        PageTemplate
    end
end
