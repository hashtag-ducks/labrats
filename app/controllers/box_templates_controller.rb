class BoxTemplatesController < ApplicationController
  include NotebookAccessHelper

  before_filter :signed_in_user
  before_filter :notebook_owner, only: :destroy

  respond_to :json

  def update
    box_template = BoxTemplate.find(params[:id])
    # WOO METAPROGRAMMING MAGIC
    #
    # To elaborate: we don't want all the attributes of the box to be
    # updatable, just those which are explicitly
    # attr_accessible-ified. So we filter those out before doing the
    # update, asking the class to supply which params these actually
    # are. Neato.
    filtered_params = params[:box_template].select do |k, v|
      box_template.class.accessible_attributes.include? k
    end
    if box_template.update_attributes(filtered_params)
      respond_with box_template
    else
      respond_with box_template, status: :unprocessable_entity
    end
  end

  def create
    # This bears explaining, probably. We need to instantiate the
    # right class based on what we're getting from Backbone, which is
    # passed along in the :type parameter. But just evaling for the
    # class is a bigass security problem, so assert that it's a
    # subclass of Box before actually instantiating it.
    box_template_class = eval(params[:box_template][:type])
    unless box_template_class < BoxTemplate
      render text: "", status: :unauthorized
      return
    end
    @box_template = box_template_class.new(params[:box_template])
    check_user(@box_template) && return
    if @box_template.save
      render json: @box_template
    else
      render json: @box_template, status: :unprocessable_entity
    end
  end

  def destroy
    BoxTemplate.find(params[:id]).destroy
    respond_to do |format|
      format.json { head :ok }
    end
  end

  def model_class
    BoxTemplate
  end
end
