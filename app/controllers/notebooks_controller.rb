class NotebooksController < ApplicationController
  before_filter :correct_user, only: [:show, :delete]

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
    @notebooks = current_user.notebook.all
  end

  def show
    @notebook = Notebook.find(params[:id])
  end

  def destroy
    Notebook.find(params[:id]).delete
    redirect_to action: 'index'
  end

  private

  def correct_user
    @notebook = Notebook.find_by_id(params[:id])
    redirect_to root_url unless current_user?(@notebook.user)
  end
end
