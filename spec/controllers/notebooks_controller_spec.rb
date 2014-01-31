require 'spec_helper'

describe NotebooksController do
    before do
        @user = FactoryGirl.create(:user)
        sign_in @user
    end

    describe "POST #create" do

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
        before :each do
            @notebook = FactoryGirl.create(:notebook, :owner => @user)
        end

        it "should delete the Notebook" do
            expect {
                delete :destroy, id: @notebook
            }.to change(Notebook, :count).by(-1)
        end

        it "should redirect to the current user's list of notebooks" do
            delete :destroy, id: @notebook
            response.should redirect_to user_notebooks_url(@user)
        end
    end

    describe "GET #index" do
        before do
            @notebook = FactoryGirl.create(:notebook, :owner => @user)
        end

        it "should find all of the current user's notebooks" do
            get :index, :user_id => @user.id
            @user.notebooks.each do |n|
                assigns(:notebooks).should include n
            end
        end

        it "should assign a new Notebook to @notebook" do
            get :index, :user_id => @user.id
            assigns(:notebook).should be_a(Notebook)
        end
    end

    describe "GET #show" do
        before do
            @notebook = FactoryGirl.create(:notebook, :owner => @user)
        end

        #TODO: make this pass
        #it "should assign the requested notebook to @notebook" do
        #    get :show, id: @notebook
        #    assigns(:notebook).should eq @notebook
        #end

        #TODO: make this pass
        #context "as the notebook's owner" do
        #    it "should render the owner's view of the notebook" do
        #        get :show, id: @notebook
        #        response.should render_template('show_owner')
        #    end
        #end

        context "as a user with valid permissions who is not the notebook's owner" do
            before do
                other_user = FactoryGirl.create(:user)
                @notebook.users << other_user
                sign_in other_user
            end

            it "should render the shared view of the notebook" do
                get :show, id: @notebook
                response.should render_template('show_shared')
            end
        end

        #TODO: make this pass
        #context "as a user without valid permissions" do
        #    before do
        #        wrong_user = FactoryGirl.create(:user)
        #        sign_in wrong_user
        #    end

        #    it "should flash an error and redirect to root" do
        #        get :show, id: @notebook
        #        flash[:error].should_not be nil
        #        response.should redirect_to root_url
        #    end
        #end
    end
end
