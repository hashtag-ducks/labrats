module NotebookAccessHelper
  private

  def notebook_owner
    model = self.model_class.find_by_id(params[:id])
    redirect_to root_url unless current_user?(model.owner)
  end

  def allowed_access
    model = self.model_class.find_by_id(params[:id])
    redirect_to root_url unless current_user?(model.user)
  end

  def check_user(model)
    unless current_user?(model.notebook.owner)
      respond_to do |format|
        format.json { head :unauthorized }
      end
    end
  end
end
