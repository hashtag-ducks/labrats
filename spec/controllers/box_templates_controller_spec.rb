require 'spec_helper'

describe BoxTemplatesController do
    before do
        @user = FactoryGirl.create(:user)
        @notebook = FactoryGirl.create(:notebook, :owner => @user)
        @page_template = FactoryGirl.create(:page_template, :notebook => @notebook)
        @tab_group_template = FactoryGirl.create(:tab_group_template, :page_template => @page_template)
        request.accept = "application/json"
    end

    describe "PUT #update" do
    end

    describe "POST #create" do
        context "with valid user permissions" do
            before do
                sign_in @user
            end

            it "should respond with correct JSON on successful save" do
                post :create, :box_template => {:tab_group_template_id => @tab_group_template.id, :type => "TextBoxTemplate"}, :tab_group_template_id => @tab_group_template.id
                response.should be_success
                body = JSON.parse(response.body)
                body.should include('content', 'created_at', 'file', 'image', 'name', 'id', 'ordering', 'tab_group_template_id', 'updated_at', 'type')
                body['tab_group_template_id'].should == @tab_group_template.id
            end

            it "should create a new BoxTemplate" do
                expect {
                    post :create, :box_template => {:tab_group_template_id => @tab_group_template.id, :type => "TextBoxTemplate"}, :tab_group_template_id => @tab_group_template.id
                }.to change(BoxTemplate, :count).by(1)
            end

            it "should respond with a 422 unprocessable entity status on failed save" do
                BoxTemplate.any_instance.stub(:save).and_return(false) #tells any subsequent instance to return false when attempting to save
                post :create, :box_template => {:tab_group_template_id => @tab_group_template.id, :type => "TextBoxTemplate"}, :tab_group_template_id => @tab_group_template.id
                expect(response.status).to be 422
            end

            it "should respond with a 401 unauthorized status when given an invalid BoxTemplate type" do
                post :create, :box_template => {:tab_group_template_id => @tab_group_template.id, :type => "TextBox"}, :tab_group_template_id => @tab_group_template.id
                expect(response.status).to be 401
            end
        end

        context "with invalid user permissions" do
            it "should respond with a 401 unauthorized status" do
                wrong_user = FactoryGirl.create(:user)
                sign_in wrong_user
                post :create, :box_template => {:tab_group_template_id => @tab_group_template.id, :type => "TextBoxTemplate"}, :tab_group_template_id => @tab_group_template.id
                expect(response.status).to be 401
            end
        end
    end

    describe "DELETE #destroy" do
        before do
            @box_template = FactoryGirl.create(:box_template, :tab_group_template => @tab_group_template)
            sign_in @user
        end

        it "should delete the BoxTemplate" do
            expect {
                delete :destroy, id: @box_template
            }.to change(BoxTemplate, :count).by(-1)
        end

        it "should respond with a 200 okay status" do
            delete :destroy, id: @box_template
            expect(response.status).to be 200
        end
    end
end
