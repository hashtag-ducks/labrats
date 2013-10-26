require 'spec_helper'

describe TabGroup do
  before do
    @tab_group = FactoryGirl.create(:tab_group)
  end

  subject { @tab_group }

  it { should respond_to(:notebook) }
  it { should respond_to(:page) }
  it { should respond_to(:owner) }
  it { should respond_to(:boxes) }

  it { should be_valid }

  describe 'Missing attributes' do
    describe 'page' do
      before { @tab_group.page = nil }
      it { should_not be_valid }
    end
  end

  it 'includes boxes in its JSON representation' do
    expect(@tab_group.as_json).to have_key(:boxes)
  end

  it 'destroys its tab groups on destroy' do
    @tab_group.save
    box = Box.new
    box.tab_group = @tab_group
    box.save
    expect(@tab_group.boxes.count).to equal(1)
    @tab_group.destroy
    expect(@tab_group.boxes.count).to equal(0)
  end
end
