class NotebooksController < ApplicationController
  def new
    @notebook = Notebook.new
    @notebook.user = current_user
  end

  def create
    @notebook = Notebook.new(params[:notebook])
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
end
