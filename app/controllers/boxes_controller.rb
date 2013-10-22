class BoxesController < ApplicationController
  before_filter :signed_in_user

  respond_to :json

  def update
    box = Box.find(params[:id])
    filtered_params = params[:box].select do |k, v|
      [:content, :name].include? k.to_sym
    end
    if box.update_attributes(filtered_params)
      respond_with box
    else
      respond_with box, status: :unprocessable_entity
    end
  end

  def create
    # This bears explaining, probably. We need to instantiate the
    # right class based on what we're getting from Backbone, which is
    # passed along in the :type parameter. But just evaling for the
    # class is a bigass security problem, so assert that it's a
    # subclass of Box before actually instantiating it.
    box_class = eval(params[:box][:type])
    unless box_class < Box
      render text: "", status: :unauthorized
      return
    end
    @box = box_class.new(params[:box])
    if @box.save
      render json: @box
    else
      render json: box, status: :unprocessable_entity
    end
  end

  def destroy
    Box.find(params[:box_id]).destroy
    respond_to do |format|
      format.json { head :ok }
    end
  end
end
