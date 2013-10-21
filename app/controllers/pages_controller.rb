class PagesController < ApplicationController
  before_filter :signed_in_user

  respond_to :json

  def create
    @page = Page.new(params[:page])
    if @page.save
      respond_with @page
    else
      respond_with @page, status: :unprocessable_entity
    end
  end

  def destroy
    @page = Page.find(params[:id])
    @page.delete
  end
end
