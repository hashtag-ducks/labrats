require 'spec_helper'

describe PagesController do
    before do
        @user = FactoryGirl.create(:user)
        @notebook = FactoryGirl.create(:notebook, :owner => @user)
        @page_template = FactoryGirl.create(:page_template, :notebook => @notebook)
        @page = FactoryGirl.create(:page, :page_template => @page_template, :user => @user)
        sign_in @user
        request.accept = "application/json"
    end

    describe "GET #show" do
        it "should find the correct Page" do
            get :show, id: @page
            assigns(:page).should eq @page
        end

        it "should respond with correct JSON" do
            get :show, id: @page
            response.should be_success
            body = JSON.parse(response.body)
            body.should include('created_at', 'id', 'ordering', 'name', 'page_template_id', 'user_id', 'updated_at', 'tab_groups')
            body['page_template_id'].should == @page_template.id
            body['user_id'].should == @user.id
        end
    end
end
