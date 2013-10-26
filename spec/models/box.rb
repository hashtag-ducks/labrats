require 'spec_helper'

describe Box do
  before do
    @box = FactoryGirl.create(:box)
  end

  subject { @box }

  it { should respond_to(:notebook) }
  it { should respond_to(:tab_group) }
  it { should respond_to(:owner) }
  it { should respond_to(:type) }

  it { should be_valid }

  describe 'Missing attributes' do
    describe 'tab group' do
      before { @box.tab_group = nil }
      it { should_not be_valid }
    end
  end

  it 'includes type in its JSON representation' do
    expect(@box.as_json).to have_key(:type)
  end
end
