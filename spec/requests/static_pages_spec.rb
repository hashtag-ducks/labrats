require 'spec_helper'

describe 'Static pages' do

  subject { page }

  describe 'Home page' do
    before { visit '/' }

    it { should have_content('Labrats') }
    it { should have_selector('li a', text: "Sign in") }
    it { should have_selector('li a', text: "Sign up") }
  end

  describe 'Signin page' do
    before { visit '/signin' }

    it { should have_content('Sign In') }
    it { should have_selector('input[type="password"]') }
  end

  describe 'Signup page' do
    before { visit '/signup' }

    it { should have_content('Create an account!') }
    it { should have_css('input[type="text"]', count: 3) }
    it { should have_css('input[type="password"]', count: 2) }
  end
end
