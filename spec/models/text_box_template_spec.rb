require 'spec_helper'

describe TextBoxTemplate do
  before do
    @text_box_template = FactoryGirl.create(:text_box_template)
  end

  subject { @text_box_template }

  it { should respond_to(:content) }
end
