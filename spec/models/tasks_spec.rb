require "rails_helper"

RSpec.describe Task, :type => :model do
  subject { described_class.new }

  it "is valid with valid attributes" do
    subject.title = "task title"
    subject.content = "task content"
    subject.deadline = 2.days.from_now
    expect(subject).to be_valid
  end

  it "is not valid without title and content" do
    subject.deadline = 2.days.from_now
    expect(subject).to_not be_valid
  end

  it "is not valid without a title" do
    subject.content = "task content"
    subject.deadline = 2.days.from_now
    expect(subject).to_not be_valid
  end

  it "is not valid without a content" do
    subject.title = "task title"
    subject.deadline = 2.days.from_now
    expect(subject).to_not be_valid
  end
end
