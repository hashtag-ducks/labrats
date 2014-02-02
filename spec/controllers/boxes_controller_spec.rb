require 'spec_helper'

describe BoxesController do
    before do
        @user = FactoryGirl.create(:user)
        @notebook = FactoryGirl.create(:notebook, :owner => @user)
        @page_template = FactoryGirl.create(:page_template, :notebook => @notebook)
        @page = FactoryGirl.create(:page, :page_template => @page_template, :user => @user)
        @tab_group_template = FactoryGirl.create(:tab_group_template, :page_template => @page_template)
        @tab_group = FactoryGirl.create(:tab_group, :page => @page, :tab_group_template => @tab_group_template)
        @box_template = FactoryGirl.create(:box_template, :tab_group_template => @tab_group_template)
        @box = FactoryGirl.create(:box, :box_template => @box_template, :tab_group => @tab_group)
        sign_in @user
        request.accept = "application/json"
    end

    describe "GET #show" do
        it "should find the correct Box" do
            get :show, id: @box
            assigns(:box).should eq @box
        end

        it "should respond with correct JSON" do
            get :show, id: @box
            response.should be_success
            body = JSON.parse(response.body)
            body.should include('created_at', 'id', 'name', 'type', 'content', 'file', 'ordering', 'tab_group_id', 'box_template_id', 'updated_at', 'image')
            body['tab_group_id'].should == @tab_group.id
            body['box_template_id'].should == @box_template.id
        end
    end

    describe "PUT #update" do
        it "should filter out non-accessible parameters" do
            put :update, id: @box, box: FactoryGirl.attributes_for(:box)
            assigns(:filtered_params).each do |k, v|
                @box.class.accessible_attributes.should include(k)
            end
        end

        it "should respond with a 422 unprocessable entity status on failed update" do
            Box.any_instance.stub(:update_attributes).and_return(false)
            put :update, id: @box, box: FactoryGirl.attributes_for(:box)
            expect(response.status).to be 422
        end
    end

    describe "POST #upload_file" do
        before do
            @file = fixture_file_upload('/test.txt', 'text/txt') #simulates uploading a file
        end

        it "should store a file in @box.file" do
            post :upload_file, id: @box, file: @file
            assigns(:box).file.should eq File.read(@file)
        end

        it "should save a file to the database" do
            post :upload_file, id: @box, file: @file
            @box.reload
            @box.file.should eq File.read(@file)
        end
    end
end
