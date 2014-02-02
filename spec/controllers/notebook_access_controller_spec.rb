require 'spec_helper'

describe NotebookAccessController do
    before do
        @owner = FactoryGirl.create(:user)
        @notebook = FactoryGirl.create(:notebook, :owner => @owner)
        @notebook.add_user @owner
        @user = FactoryGirl.create(:user)
        sign_in @owner
        request.accept = "application/json"
    end

    describe "POST #create" do
        it "should correctly assign @user and @notebook" do
            post :create, id: @notebook, user_email: @user.email
            assigns(:notebook).should eq @notebook
            assigns(:user).should eq @user
        end

        it "should add the specified user to the notebook's users" do
            post :create, id: @notebook, user_email: @user.email
            @notebook.users.should include @user
        end

        it "should respond with correct JSON on successful save" do
            post :create, id: @notebook, user_email: @user.email
            response.should be_success
            body = JSON.parse(response.body)
            body.should include('created_at', 'id', 'name', 'owner_id', 'updated_at', 'pages')
            body['owner_id'].should == @owner.id
            body['id'].should == @notebook.id
        end

        it "should respond with a 422 unprocessable entity status on failed save" do
            Notebook.any_instance.stub(:save).and_return(false)
            post :create, id: @notebook, user_email: @user.email
            expect(response.status).to be 422
        end
    end

    describe "DELETE #destroy" do
        before do
            @notebook.add_user @user
        end

        it "should correctly assign @user and @notebook" do
            delete :destroy, id: @notebook, user_email: @user.email
            assigns(:notebook).should eq @notebook
            assigns(:user).should eq @user
        end

        it "should remove the specified user from the notebook's users" do
            delete :destroy, id: @notebook.id, user_email: @user.email
            assigns(:notebook).users.should_not include @user
        end

        it "should respond with a 204 no content status on successful save" do
            delete :destroy, id: @notebook, user_email: @user.email
            expect(response.status).to be 204
        end

        it "should respond with a 422 unprocessable entity status on failed save" do
            Notebook.any_instance.stub(:save).and_return(false)
            delete :destroy, id: @notebook, user_email: @user.email
            expect(response.status).to be 422
        end
    end
end
