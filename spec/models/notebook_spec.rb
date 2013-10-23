require 'spec_helper'

describe Notebook do
  before do
    @user = User.new(name: 'duck',
                     email: 'duck@oberlin.edu',
                     organization: 'Oberlin',
                     password: 'thisisapassword',
                     password_confirmation: 'thisisapassword')
    @user.save
    @notebook = Notebook.new(name: 'notebook')
    @notebook.user = @user
  end

  subject { @notebook }

  it { should respond_to(:name) }
  it { should respond_to(:user) }
  it { should respond_to(:pages) }

  it { should be_valid }

  describe 'Missing attributes' do
    describe 'user' do
      before { @notebook.user = nil }
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
