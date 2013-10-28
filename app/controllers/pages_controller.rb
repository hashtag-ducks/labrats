class PagesController < ApplicationController
  include NotebookAccessHelper

  before_filter :signed_in_user
  before_filter :notebook_owner, only: :destroy

  respond_to :json

  def create
    @page = Page.new(params[:page])
    check_user(@page) && return
    if @page.save
      respond_with @page
    else
      respond_with @page, status: :unprocessable_entity
    end
  end

  def destroy
    Page.find(params[:id]).destroy
    respond_to do |format|
      format.json { head :ok }
    end
  end

  def model_class
    Page
  end
end
