class NotebookAccessController < ApplicationController
    include NotebookAccessHelper

    before_filter :notebook_owner

    respond_to :json

    def create
        notebook = Notebook.find(params[:id])
        user = User.find_by_email(params[:user_email])
        unless notebook.users.include? user
            notebook.add_user user
        end
        if notebook.save
            respond_with notebook
        else
            respond_with notebook, status: :unprocessable_entity
        end
    end

    def destroy
        notebook = Notebook.find(params[:id])
        user = User.find_by_email(params[:user_email])
        notebook.remove_user user
        if notebook.save
            respond_with notebook
        else
            respond_with notebook, status: :unprocessable_entity
        end
    end

    def model_class
        Notebook
    end
end
