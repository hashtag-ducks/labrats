require 'spec_helper'

describe PageTemplatesController do
    before do
        @user = FactoryGirl.create(:user)
        @notebook = FactoryGirl.create(:notebook, :owner => @user)
        request.accept = "application/json"
    end
    describe "PUT #update" do
        before do
            @page_template = FactoryGirl.create(:page_template, :notebook => @notebook)
        end 

        context "with valid user permissions" do
            before do
                sign_in @user
            end

            it "should find the correct PageTemplate" do
                put :update, id: @page_template, page_template: FactoryGirl.attributes_for(:page_template)
                assigns(:page_template).should eq(@page_template)
            end

            it "should update the name and ordering fields" do
                put :update, id: @page_template, page_template: FactoryGirl.attributes_for(:page_template)
                @page_template.reload
                @page_template.name.should eq(FactoryGirl.attributes_for(:page_template)[:name])
                @page_template.ordering.should eq(FactoryGirl.attributes_for(:page_template)[:ordering])
            end

            it "should respond with a 422 unprocessable entity status on failed save" do
                PageTemplate.any_instance.stub(:save).and_return(false)
                put :update, id: @page_template, page_template: FactoryGirl.attributes_for(:page_template)
                expect(response.status).to be 422
            end
        end

        context "with invalid user permissions" do
            it "should respond with a 401 unauthorized status" do
                wrong_user = FactoryGirl.create(:user)
                sign_in wrong_user
                put :update, id: @page_template, page_template: FactoryGirl.attributes_for(:page_template)
                expect(response.status).to be 401
            end
        end
    end

    describe "POST #create" do
        context "with valid user permissions" do
            before do
                sign_in @user
            end

            it "should respond with correct JSON on successful save" do
                post :create, :page_template => {:notebook_id => @notebook.id}, :notebook_id => @notebook.id
                response.should be_success
                body = JSON.parse(response.body)
                body.should include('created_at', 'id', 'ordering', 'name', 'notebook_id', 'updated_at', 'tab_group_templates')
                body['notebook_id'].should == @notebook.id
            end

            it "should create a new PageTemplate" do
                expect {
                    post :create, :page_template => {:notebook_id => @notebook.id}, :notebook_id => @notebook.id
                }.to change(PageTemplate, :count).by(1)
            end

            it "should respond with a 422 unprocessable entity status on failed save" do
                PageTemplate.any_instance.stub(:save).and_return(false) #tells any subsequent instance to return false when attempting to save
                post :create, :page_template => {:notebook_id => @notebook.id}, :notebook_id => @notebook.id
                expect(response.status).to be 422
            end
        end

        context "with invalid user permissions" do
            it "should respond with a 401 unauthorized status" do
                wrong_user = FactoryGirl.create(:user)
                sign_in wrong_user
                post :create, :page_template => {:notebook_id => @notebook.id}, :notebook_id => @notebook.id
                expect(response.status).to be 401
            end
        end
    end

    describe "DELETE #destroy" do
        before do
            @page_template = FactoryGirl.create(:page_template, :notebook => @notebook)
            sign_in @user
        end

        it "should delete the PageTemplate" do
            expect {
                delete :destroy, id: @page_template
            }.to change(PageTemplate, :count).by(-1)
        end

        it "should respond with a 200 okay status" do
            delete :destroy, id: @page_template
            expect(response.status).to be 200
        end
    end
end
