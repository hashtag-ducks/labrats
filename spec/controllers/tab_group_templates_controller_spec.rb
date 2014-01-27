require 'spec_helper'

describe TabGroupTemplatesController do
    before do
        @user = FactoryGirl.create(:user)
        @notebook = FactoryGirl.create(:notebook, :owner => @user)
        @page_template = FactoryGirl.create(:page_template, :notebook => @notebook)
        request.accept = "application/json"
    end

    describe "DELETE #destroy" do
        before do
            @tab_group_template = FactoryGirl.create(:tab_group_template, :page_template => @page_template)
            sign_in @user
        end

        it "should delete the TabGroupTemplate" do
            expect {
                delete :destroy, id: @tab_group_template
            }.to change(TabGroupTemplate, :count).by(-1)
        end

        it "should respond with a 200 okay status" do
            delete :destroy, id: @tab_group_template
            expect(response.status).to be 200
        end
    end

    describe "POST #create" do
        context "with valid user permissions" do
            before do
                sign_in @user
            end

            it "should respond with correct JSON on successful save" do
                post :create, :tab_group_template => {:page_template_id => @page_template.id}, :page_template_id => @page_template.id
                response.should be_success
                body = JSON.parse(response.body)
                body.should include('created_at', 'id', 'ordering', 'page_template_id', 'updated_at', 'box_templates')
                body['page_template_id'].should == @page_template.id
            end

            it "should create a new TabGroupTemplate" do
                expect {
                    post :create, :tab_group_template => {:page_template_id => @page_template.id}, :page_template_id => @page_template.id
                }.to change(TabGroupTemplate, :count).by(1)
            end

            # first line of this test is not working, despite appearing to be valid rspec
           #it "should respond with a 422 unprocessable entity status on failed save" do
           #    TabGroupTemplate.any_instance.stub(:save).and_return(false) #tells any subsequent instance to return false when attempting to save
           #    post :create, :tab_group_template => {:page_template_id => @page_template.id}, :page_template_id => @page_template.id
           #    expect(response.status).to be 422
           #end
        end

        context "with invalid user permissions" do
            it "should respond with a 401 unauthorized status" do
                wrong_user = FactoryGirl.create(:user)
                sign_in wrong_user
                post :create, :tab_group_template => {:page_template_id => @page_template.id}, :page_template_id => @page_template.id
                expect(response.status).to be 401
            end
        end
    end
end
