require 'spec_helper'

describe UsersController do
    describe "GET #new" do
        it "should create a new User" do
            get :new
            assigns(:user).should be_a User
        end
    end

    describe "POST #create" do
        it "should capitalize the User's organization" do
            post :create, user: FactoryGirl.attributes_for(:user, :organization => "oberlin")
            assigns(:user).organization.should eq "Oberlin"
        end

        it "should sign in the User and redirect to their page on a successful save" do
            post :create, user: FactoryGirl.attributes_for(:user)
            current_user.should eq assigns(:user)
            response.should redirect_to assigns(:user)
        end

        it "should render #new on a failed save" do
            User.any_instance.stub(:save).and_return(false)
            post :create, user: FactoryGirl.attributes_for(:user)
            response.should render_template('new')
        end
    end

    describe "GET #index" do
        before do
            user1 = FactoryGirl.create(:user)
            user2 = FactoryGirl.create(:user)
            user3 = FactoryGirl.create(:user)
        end

        it "should populate @users with a list of all Users" do
            get :index
            User.all.each do |user|
                assigns(:users).should include user
            end
        end
    end

    describe "GET #show" do
        before do
            @user = FactoryGirl.create(:user)
            @notebook1 = FactoryGirl.create(:notebook, :owner => @user)
            @notebook2 = FactoryGirl.create(:notebook, :owner => @user)
            @user.notebooks << @notebook1
            @user.notebooks << @notebook2
            @page_template1 = FactoryGirl.create(:page_template, :notebook => @notebook1)
            @page_template2 = FactoryGirl.create(:page_template, :notebook => @notebook1)
            @page_template3 = FactoryGirl.create(:page_template, :notebook => @notebook2)
            @page_template4 = FactoryGirl.create(:page_template, :notebook => @notebook2)
        end

        it "should find the correct User" do
            get :show, id: @user
            assigns(:user).should eq @user
        end

        it "should populate @feed with each page template from each of the User's notebooks" do
            get :show, id: @user
            assigns(:feed).should include @page_template1
            assigns(:feed).should include @page_template2
            assigns(:feed).should include @page_template3
            assigns(:feed).should include @page_template4
        end
    end

    describe "PUT #update" do
        before do
            @user = FactoryGirl.create(:user)
            sign_in @user
        end

        context "as the correct user" do
            it "should assign the correct user to @user" do
                put :update, id: @user, user: FactoryGirl.attributes_for(:user)
                assigns(:user).should eq @user
            end

            it "should not allow parameters not specified in user_params" do
                put :update, id: @user, user: FactoryGirl.attributes_for(:user, :organization => "kenyon")
                @user.reload
                @user.organization.should_not be "kenyon"
            end

            it "should flash success and redirect to the User's page on a successful update" do
                put :update, id: @user, user: FactoryGirl.attributes_for(:user)
                flash[:success].should_not be nil
                response.should redirect_to @user
            end

            it "should flash an error and render #new on a failed update" do
                User.any_instance.stub(:update_attributes).and_return(false)
                put :update, id: @user, user: FactoryGirl.attributes_for(:user)
                flash[:error].should_not be nil
                response.should render_template('edit')
            end
        end

        context "as an incorrect user" do
            before do
                @wrong_user = FactoryGirl.create(:user)
            end

            it "should redirect to root_url" do
                put :update, id: @wrong_user, user: FactoryGirl.attributes_for(:user)
                response.should redirect_to root_url
            end
        end
    end
end
