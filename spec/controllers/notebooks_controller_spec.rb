require 'spec_helper'

describe NotebooksController do
    before do
        @user = FactoryGirl.create(:user)
        request.accept = "application/json"
    end

    describe "POST #create" do
        before do
            sign_in @user
        end

        it "should redirect to the new notebook on successful save" do
            post :create, :notebook => FactoryGirl.attributes_for(:notebook), :user_id => @user.id
            response.should redirect_to Notebook.last
        end

        it "should create a notebook belonging to the current user" do
            post :create, :notebook => FactoryGirl.attributes_for(:notebook), :user_id => @user.id
            assigns(:notebook).owner.should eq @user
            assigns(:notebook).users.should include @user
        end

        it "should create a new Notebook" do
            expect {
                post :create, :notebook => FactoryGirl.attributes_for(:notebook), :user_id => @user.id
            }.to change(Notebook, :count).by(1)
        end

        it "should render index on failed save" do
            Notebook.any_instance.stub(:save).and_return(false) #tells any subsequent instance to return false when attempting to save
            post :create, :notebook => FactoryGirl.attributes_for(:notebook), :user_id => @user.id
            response.should render_template("index")
        end
    end

    describe "DELETE #destroy" do
    end

    describe "GET #index" do
        before do
            sign_in @user
            @notebook = FactoryGirl.create(:notebook, :owner => @user)
        end

        it "should find all of the current user's notebooks" do
            get :index, :user_id => @user.id
            @user.notebooks.each do |n|
                assigns(:notebooks).should include n
            end
        end
    end

    describe "GET #show" do
    end
end
