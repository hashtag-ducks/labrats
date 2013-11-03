require 'spec_helper'

describe PageTemplate do
  before do
    @page_template = FactoryGirl.create(:page_template)
  end

  subject { @page_template }

  it { should respond_to(:notebook) }
  it { should respond_to(:owner) }
  it { should respond_to(:tab_group_templates) }

  it { should be_valid }

  describe 'Missing attributes' do
    describe 'notebook' do
      before { @page_template.notebook = nil }
      it { should_not be_valid }
    end
  end

  it 'includes tab groups in its JSON representation' do
    expect(@page_template.as_json).to have_key(:tab_group_templates)
  end

  it 'destroys its tab groups on destroy' do
    @page_template.save
    tab_group = TabGroupTemplate.new
    tab_group.page_template = @page_template
    tab_group.save
    expect(@page_template.tab_group_templates.count).to equal(1)
    @page_template.destroy
    expect(@page_template.tab_group_templates.count).to equal(0)
  end
end
