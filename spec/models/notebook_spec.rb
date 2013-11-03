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
end
