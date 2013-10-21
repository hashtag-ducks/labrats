class NotebooksController < ApplicationController
  before_filter :correct_user, only: [:show, :delete]
  before_filter :signed_in_user

  def new
    @notebook = Notebook.new
  end

  def create
    @notebook = Notebook.new(params[:notebook])
    @notebook.user = current_user
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

  private

  def correct_user
    @notebook = Notebook.find_by_id(params[:id])
    redirect_to root_url unless current_user?(@notebook.user)
  end
end
