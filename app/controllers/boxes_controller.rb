class BoxesController < ApplicationController
  include NotebookAccessHelper

  before_filter :signed_in_user
  before_filter :notebook_owner, only: :destroy

  respond_to :json

  def update
    box = Box.find(params[:id])
    # WOO METAPROGRAMMING MAGIC
    #
    # To elaborate: we don't want all the attributes of the box to be
    # updatable, just those which are explicitly
    # attr_accessible-ified. So we filter those out before doing the
    # update, asking the class to supply which params these actually
    # are. Neato.
    filtered_params = params[:box].select do |k, v|
      box.class.accessible_attributes.include? k
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
    check_user(@box) && return
    if @box.save
      render json: @box
    else
      render json: box, status: :unprocessable_entity
    end
  end

  def destroy
    Box.find(params[:id]).destroy
    respond_to do |format|
      format.json { head :ok }
    end
  end

  def model_class
    Box
  end
end
