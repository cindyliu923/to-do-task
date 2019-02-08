require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new }

  it "is valid with valid attributes" do
    subject.name = "Name"
    subject.email = "valid@example.com"
    subject.password = "password"
    expect(subject).to be_valid
  end

  it "is not valid without name and email and password" do
    subject.name = ''
    subject.email = ''
    subject.password = ''
    expect(subject).to_not be_valid
  end

  it "is not valid with invalid email" do
    subject.name = "Name"
    subject.email = "invalid_email"
    subject.password = "password"
    expect(subject).to_not be_valid
  end

  it "is not valid without short password" do
    subject.name = "Name"
    subject.email = "valid@example.com"
    subject.password = "1"
    expect(subject).to_not be_valid
  end

  it "when user delete user task delete too" do
    user = FactoryBot.create(:user)
    task = FactoryBot.create(:task, user: user)

    expect { user.destroy }.to change { Task.count }.by(-1)
  end
end
