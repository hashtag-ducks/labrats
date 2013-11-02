class PagesController < ApplicationController
  include NotebookAccessHelper

  before_filter :signed_in_user
  before_filter :allowed_access

  respond_to :json

  def show
    @page = Page.find(params[:id])
    respond_with @page
  end

  def model_class
    Page
  end
end
