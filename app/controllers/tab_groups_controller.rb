class TabGroupsController < ApplicationController
  include NotebookAccessHelper

  before_filter :signed_in_user
  before_filter :notebook_owner, only: :destroy

  respond_to :json

  def create
    @tab_group = TabGroup.create(params[:tab_group])
    check_user(@tab_group) && return
    if @tab_group.save
      respond_with @tab_group
    else
      respond_with @tab_group, status: :unprocessable_entity
    end
  end

  def destroy
    TabGroup.find(params[:id]).destroy
    respond_to do |format|
      format.json { head :ok }
    end
  end

  def model_class
    TabGroup
  end
end
