require "rails_helper"

RSpec.describe Task, :type => :model do
  subject { described_class.new }
  it { should define_enum_for(:status).with_values([:todo, :doing, :done]) }

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

  it "status transition only from todo to doing and from doing to down" do
    task = Task.new
    expect(task).to have_state(:todo)
    expect(task).not_to have_state(:doing)
    expect(task).to allow_event :up
    expect(task).to_not allow_event :down
    expect(task).to allow_transition_to(:doing)
    expect(task).to_not allow_transition_to(:done)
    expect(task).to transition_from(:todo).to(:doing).on_event(:up)
    expect(task).not_to transition_from(:todo).to(:done).on_event(:up)

    expect(task).to have_state(:doing)
    expect(task).not_to have_state(:done)
    expect(task).to allow_event :down
    expect(task).to_not allow_event :up
    expect(task).to allow_transition_to(:done)
    expect(task).to_not allow_transition_to(:todo)
    expect(task).to transition_from(:doing).to(:done).on_event(:down)
    expect(task).not_to transition_from(:doing).to(:todo).on_event(:down)
  end

end
