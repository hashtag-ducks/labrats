class NotebooksController < ApplicationController
  def index
    @notebooks = current_user.notebook.all
  end

  def show
    @notebook = Notebook.find(params[:id])
  end
end
