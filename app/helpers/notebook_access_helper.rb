module NotebookAccessHelper
  private

  def notebook_owner
    @notebook = Notebook.find_by_id(params[:id] || params[:notebook_id])
    redirect_to root_url unless current_user?(@notebook.owner)
  end

  def allowed_access
    @notebook = Notebook.find_by_id(params[:id])
    redirect_to root_url unless @notebook.users.include?(current_user)
  end
end
