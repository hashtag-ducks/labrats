require 'spec_helper'

describe UsersHelper do
  before do
    @user = FactoryGirl.create(:user)
  end

  subject { @user }

  describe 'gravatar_for' do
    it 'creates an image tag with the correct URL' do
      img_tag = gravatar_for @user
      gravatar_regex = /src="https:\/\/secure.gravatar.com\/avatar\/[0-9a-f]{32}"/
      expect(gravatar_regex).to match(img_tag)
    end
  end
end
