require 'spec_helper'

describe TextBox do
  before do
    @text_box = FactoryGirl.create(:text_box)
  end

  subject { @text_box }

  it { should respond_to(:content) }
end
