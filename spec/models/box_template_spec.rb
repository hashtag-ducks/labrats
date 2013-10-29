require 'spec_helper'

describe BoxTemplate do
  before do
    @box_template = FactoryGirl.create(:box_template)
  end

  subject { @box_template }

  it { should respond_to(:notebook) }
  it { should respond_to(:tab_group_template) }
  it { should respond_to(:owner) }
  it { should respond_to(:type) }

  it { should be_valid }

  describe 'Missing attributes' do
    describe 'tab group' do
      before { @box_template.tab_group_template = nil }
      it { should_not be_valid }
    end
  end

  it 'includes type in its JSON representation' do
    expect(@box_template.as_json).to have_key(:type)
  end
end
