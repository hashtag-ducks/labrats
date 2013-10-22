require 'spec_helper'

describe User do
  before { @user = User.new(name: 'duck',
                            email: 'duck@oberlin.edu',
                            organization: 'Oberlin',
                            password: 'thisisapassword',
                            password_confirmation: 'thisisapassword') }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:organization) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:authenticate) }

  it { should be_valid }

  describe 'User missing attributes' do
    describe 'name' do
      before { @user.name = nil }
      it { should_not be_valid }
    end

    describe 'email' do
      before { @user.email = nil }
      it { should_not be_valid }
    end

    describe 'organization' do
      before { @user.organization = nil }
      it { should_not be_valid }
    end

    describe 'password' do
      before { @user.password = @user.password_confirmation = nil }
      it { should_not be_valid }
    end
  end

  describe 'User with invalid attributes' do
    describe 'name too long' do
      before { @user.name = 'name'*50 }
      it { should_not be_valid }
    end

    describe 'bad email' do
      before { @user.email = 'not_an@email' }
      it { should_not be_valid }
    end

    describe 'mismatched passwords' do
      before { @user.password_confirmation = 'nope' }
      it { should_not be_valid }
    end

    describe 'short password' do
      before { @user.password = @user.password_confirmation = 'short' }
      it { should_not be_valid }
    end
  end

  describe 'Users with non-unique emails' do
    before do
      same_email_user = @user.dup
      same_email_user.email = @user.email.upcase
      same_email_user.save
    end

    it { should_not be_valid }
  end

  describe 'authenticate method' do
    before { @user.save }
    let(:found_user) { User.find_by_email @user.email }

    describe 'valid password' do
      it { should == found_user.authenticate(@user.password) }
    end

    describe 'invalid password' do
      let(:invalid_password_user) { found_user.authenticate('wrong password') }
      
      it { should_not == invalid_password_user }
      specify { invalid_password_user.should be_false }
    end
  end
end
