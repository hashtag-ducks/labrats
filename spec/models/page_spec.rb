require 'spec_helper'

describe Page do
  before do
    @page = FactoryGirl.create(:page)
  end

  subject { @page }

  it { should respond_to(:notebook) }
  it { should respond_to(:owner) }
  it { should respond_to(:tab_groups) }

  it { should be_valid }

  describe 'Missing attributes' do
    describe 'notebook' do
      before { @page.notebook = nil }
      it { should_not be_valid }
    end
  end

  it 'includes tab groups in its JSON representation' do
    expect(@page.as_json).to have_key(:tab_groups)
  end

  it 'destroys its tab groups on destroy' do
    @page.save
    tab_group = TabGroup.new
    tab_group.page = @page
    tab_group.save
    expect(@page.tab_groups.count).to equal(1)
    @page.destroy
    expect(@page.tab_groups.count).to equal(0)
  end
end
