class TabGroupsController < ApplicationController
  before_filter :signed_in_user

  respond_to :json

  def create
    @tab_group = TabGroup.create(params[:tab_group])
    if @tab_group.save
      respond_with @tab_group
    else
      respond_with @tab_group, status: :unprocessable_entity
    end
  end

  def destroy
    TabGroup.find(params[:tab_group_id]).destroy
    respond_to do |format|
      format.json { head :ok }
    end
  end
end
