require 'rails_helper'

RSpec.describe User, type: :model do
  subject {  User.new(username: Faker::Internet.username,
                      email: Faker::Internet.email,
                      password: Faker::Internet.password)
  }

  before { subject.save }

  it 'should be valid' do
    expect(subject).to be_valid
  end

  it 'should require a name' do
    subject.username = nil
    expect(subject).to_not be_valid
  end

  it 'should require a username of at least 3 characters' do
    subject.username = 'a' * 2
    subject.valid?
    expect(subject.errors[:username]).to include("is too short (minimum is 3 characters)")
  end

  it 'should save a authentication token' do
    subject.save

    expect(subject.authentication_token).to be_present
  end
end
