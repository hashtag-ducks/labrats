require 'spec_helper'

describe TabGroupTemplate do
  before do
    @tab_group_template = FactoryGirl.create(:tab_group_template)
  end

  subject { @tab_group_template }

  it { should respond_to(:notebook) }
  it { should respond_to(:page_template) }
  it { should respond_to(:owner) }
  it { should respond_to(:box_templates) }

  it { should be_valid }

  describe 'Missing attributes' do
    describe 'page' do
      before { @tab_group_template.page_template = nil }
      it { should_not be_valid }
    end
  end

  it 'includes boxes in its JSON representation' do
    expect(@tab_group_template.as_json).to have_key(:box_templates)
  end

  it 'destroys its tab groups on destroy' do
    @tab_group_template.save
    box = BoxTemplate.new
    box.tab_group_template = @tab_group_template
    box.save
    expect(@tab_group_template.box_templates.count).to equal(1)
    @tab_group_template.destroy
    expect(@tab_group_template.box_templates.count).to equal(0)
  end
end
