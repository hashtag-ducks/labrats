class TabGroupsController < ApplicationController
  include NotebookAccessHelper

  before_filter :signed_in_user
  before_filter :allowed_access

  respond_to :json

  def show
    @tab_group = TabGroup.find(params[:id])
    respond_with @tab_group
  end

  def model_class
    TabGroup
  end
end
