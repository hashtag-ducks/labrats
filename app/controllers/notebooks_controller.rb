class NotebooksController < ApplicationController
  include NotebookAccessHelper

  before_filter :notebook_owner, only: :destroy
  before_filter :signed_in_user

  def create
    @notebook = Notebook.new(params[:notebook])
    @notebook.owner = current_user
    @notebook.users << current_user
    if @notebook.save
      redirect_to @notebook
    else
      render 'index'
    end
  end

  def index
    @notebooks = current_user.notebooks.all
    @notebook = Notebook.new
  end

  def show
    @notebook = Notebook.find(params[:id])
    if !@notebook.users.include? current_user
        flash[:error] = "No street cred"
        redirect_to root_url && return
    end

    if current_user?(@notebook.owner)
      render 'show_owner'
    else
      render 'show_shared'
    end
  end

  def destroy
    Notebook.find(params[:id]).destroy
    redirect_to user_notebooks_url(current_user)
  end

  def model_class
    Notebook
  end
end
