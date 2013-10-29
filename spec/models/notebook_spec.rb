require 'spec_helper'

describe Notebook do
  before do
    @notebook = FactoryGirl.create(:notebook)
  end

  subject { @notebook }

  it { should respond_to(:name) }
  it { should respond_to(:owner) }
  it { should respond_to(:pages) }

  it { should be_valid }

  describe 'Missing attributes' do
    describe 'owner' do
      before { @notebook.owner_id = nil }
      it { should_not be_valid }
    end
  end

  it "includes pages in its JSON representation" do
    expect(@notebook.as_json).to have_key(:pages)
  end

  it "destroys its pages on destroy" do
    @notebook.save
    page = Page.new
    page.notebook = @notebook
    page.save
    expect(@notebook.pages.count).to equal(1)
    @notebook.destroy
    expect(@notebook.pages.count).to equal(0)
  end
end
