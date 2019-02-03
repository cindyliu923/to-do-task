require "rails_helper"

RSpec.describe Task, :type => :model do
  subject { described_class.new }

  it "is valid with valid attributes" do
    subject.title = "task title"
    subject.content = "task content"
    expect(subject).to be_valid
  end

  it "is not valid without a title" do
    expect(subject).to_not be_valid
  end

  it "is not valid without a content" do
    subject.title = "task title"
    expect(subject).to_not be_valid
  end
end
