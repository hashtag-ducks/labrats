require 'spec_helper'

describe SessionsController do
    before do
        @user = FactoryGirl.create(:user)
    end

    describe "GET #new" do
        it "should redirect to the current user if one exists" do
            sign_in @user
            get :new
            response.should redirect_to @user
        end
    end

    describe "POST #create" do
        it "should correctly assign the session's user to @user" do
            post :create, :session => {email: @user.email}
            assigns(:user).should eq @user
        end

        it "should sign in the user if they authenticate successfully" do
            post :create, :session => {email: @user.email, password: @user.password}
            current_user.should eq @user
            response.should redirect_to @user
        end

        it "should flash an error and render new if the user fails to authenticate" do
            post :create, :session => {email: @user.email}
            flash[:error].should_not be nil
            response.should render_template('new')
        end
    end

    describe "DELETE #destroy" do
        before do
            sign_in @user
        end

        it "should sign out the current user and redirect to root_url" do
            delete :destroy
            controller.should_not be_signed_in
            response.should redirect_to root_url
        end
    end
end
