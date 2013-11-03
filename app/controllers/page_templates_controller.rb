class PageTemplatesController < ApplicationController
  include NotebookAccessHelper

  before_filter :signed_in_user
  before_filter :notebook_owner

  respond_to :json

  def create
    @page_template = PageTemplate.new(params[:page])
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

  def model_class
    PageTemplate
  end
end
