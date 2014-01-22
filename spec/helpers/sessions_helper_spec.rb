require 'spec_helper'

describe SessionsHelper do
  before do
    @user = FactoryGirl.create(:user)
  end

  describe 'sign_in' do
    it 'starts without a signed in user' do
      expect(helper.current_user).to be(nil)
    end

    it 'sets the current user' do
      helper.sign_in @user
      expect(helper.current_user).to be(@user)
    end

    it 'sets a remember token' do
      helper.sign_in @user
      expect(cookies[:remember_token]).not_to be(nil)
    end
  end

  describe 'sign_out' do
    before do
      helper.sign_in @user
    end

    it 'sets the current user to nil' do
      helper.sign_out
      expect(helper.current_user).to be(nil)
    end

    it 'deletes the remember token' do
      expect(cookies[:remember_token]).not_to be(nil)
      helper.sign_out
      expect(cookies[:remember_token]).to be(nil)
    end
  end

  describe 'signed_in?' do
    it 'correctly reports signed in status' do
      expect(helper.signed_in?).to be_false
      helper.sign_in @user
      expect(helper.signed_in?).to be_true
    end
  end

  describe 'current_user?' do
    it 'works' do
      expect(current_user?(@user)).to be(false)
      helper.sign_in @user
      expect(current_user?(@user)).to be(true)
    end
  end
end
