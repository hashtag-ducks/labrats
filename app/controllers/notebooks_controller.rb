class NotebooksController < ApplicationController
  include NotebookAccessHelper

  before_filter :notebook_owner, only: :destroy
  before_filter :allowed_access, only: :show
  before_filter :signed_in_user

  def new
    @notebook = Notebook.new
  end

  def create
    @notebook = Notebook.new(params[:notebook])
    @notebook.owner = current_user
    @notebook.users << current_user
    if @notebook.save
      redirect_to @notebook
    else
      render 'new'
    end
  end

  def index
    @notebooks = current_user.notebooks.all
  end

  def show
    @notebook = Notebook.find(params[:id])
  end

  def destroy
    Notebook.find(params[:id]).destroy
    redirect_to user_notebooks_url(current_user)
  end

  def model_class
    Notebook
  end
end
