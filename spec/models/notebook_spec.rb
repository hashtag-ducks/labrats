require 'spec_helper'

describe Notebook do
  before do
    @notebook = FactoryGirl.create(:notebook)
  end

  subject { @notebook }

  it { should respond_to(:name) }
  it { should respond_to(:owner) }
  it { should respond_to(:page_templates) }

  it { should be_valid }

  describe 'Missing attributes' do
    describe 'owner' do
      before { @notebook.owner_id = nil }
      it { should_not be_valid }
    end
  end

  it "includes page templates in its JSON representation for owners" do
    expect(@notebook.as_json(user: @notebook.owner)).to have_key(:page_templates)
  end

  it "includes pages in its JSON representation for other users" do
    expect(@notebook.as_json).to have_key(:pages)
  end

  it "destroys its pages on destroy" do
    @notebook.save
    page = PageTemplate.new
    page.notebook = @notebook
    page.save
    expect(@notebook.page_templates.count).to equal(1)
    @notebook.destroy
    expect(@notebook.page_templates.count).to equal(0)
  end

  describe 'setup_defaults' do
    it 'starts with no pages' do
      expect(PageTemplate.where(notebook_id: @notebook.id).length).to equal(0)
    end

    it 'adds a page when called' do
      @notebook.setup_defaults
      expect(PageTemplate.where(notebook_id: @notebook.id).length).to equal(1)
    end
  end

  describe 'add_user' do
    before do
      @user = FactoryGirl.create(:user)
    end

    it 'adds a user' do
      users_count = @notebook.users.length
      @notebook.add_user(@user)
      expect(@notebook.users.length).to equal(users_count + 1)
    end

    it 'creates a copy of this notebook' do
      @notebook.setup_defaults
      @notebook.add_user(@user)
      expect(@user.notebooks.length).to equal(1)
      expect(@user.notebooks.first.owner_id).to equal(@notebook.owner_id)
    end
  end

  describe 'remove_user' do
    before do
      @user = FactoryGirl.create(:user)
      @notebook.add_user(@user)
    end

    it 'removes a user' do
      users_count = @notebook.users.length
      @notebook.remove_user(@user)
      expect(@notebook.users.length).to equal(users_count - 1)
    end

    it "destroys that user's copy" do
      @notebook.remove_user(@user)
      expect(@user.notebooks.length).to equal(0)
    end
  end
end
