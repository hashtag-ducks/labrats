require 'spec_helper'

describe TabGroupsController do
    before do
        @user = FactoryGirl.create(:user)
        @notebook = FactoryGirl.create(:notebook, :owner => @user)
        @page_template = FactoryGirl.create(:page_template, :notebook => @notebook)
        @page = FactoryGirl.create(:page, :page_template => @page_template, :user => @user)
        @tab_group_template = FactoryGirl.create(:tab_group_template, :page_template => @page_template)
        @tab_group = FactoryGirl.create(:tab_group, :page => @page, :tab_group_template => @tab_group_template)
        sign_in @user
        request.accept = "application/json"
    end

    describe "GET #show" do
        it "should find the correct TabGroup" do
            get :show, id: @tab_group
            assigns(:tab_group).should eq @tab_group
        end

        it "should respond with correct JSON" do
            get :show, id: @tab_group
            response.should be_success
            body = JSON.parse(response.body)
            body.should include('created_at', 'id', 'ordering', 'tab_group_template_id', 'page_id', 'updated_at', 'boxes')
            body['tab_group_template_id'].should == @tab_group_template.id
            body['page_id'].should == @page.id
        end
    end
end
